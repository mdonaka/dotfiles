#!/bin/bash
#
# Claude Code 通知プラグイン (WSL) - タスク完了通知 (Stop hook)
#
# タスク完了時に最後のアシスタントメッセージを含む通知を送信する。
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

# 依存関係がない場合は静かに終了（UserPromptSubmitでチェック済み）
command -v jq &> /dev/null || exit 0
command -v powershell.exe &> /dev/null || exit 0

# stdin から hook JSON を読み込む
HOOK_JSON=$(read_hook_json)

# hook JSON から transcript_path を取得
TRANSCRIPT_PATH=""
if [ -n "$HOOK_JSON" ]; then
    TRANSCRIPT_PATH=$(echo "$HOOK_JSON" | jq -r '.transcript_path // empty')
fi

# transcript から最後のアシスタントメッセージを抽出
LAST_MESSAGE=""
ASSISTANT_LINE=$(search_transcript "$TRANSCRIPT_PATH" '"type":"assistant"')
if [ -n "$ASSISTANT_LINE" ]; then
    # テキストコンテンツを抽出し、HTML タグを除去
    LAST_MESSAGE=$(echo "$ASSISTANT_LINE" | jq -r '.message.content[] | select(.type == "text") | .text' 2>/dev/null | sed 's/<[^>]*>//g' || true)
fi

# メッセージをフォーマット
if [ -n "$LAST_MESSAGE" ]; then
    FORMATTED_MESSAGE=$(format_message "$LAST_MESSAGE")
else
    FORMATTED_MESSAGE="Task completed"
fi

# プロジェクト名を設定
PROJECT_NAME="${CLAUDE_PROJECT_DIR:-$PWD}"
PROJECT_NAME="${PROJECT_NAME##*/}"

# 通知を送信（macOSの"Blow"相当としてMailを使用）
send_notification "[${PROJECT_NAME}] complete" "$FORMATTED_MESSAGE" "Mail"
