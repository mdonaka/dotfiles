#!/bin/bash
#
# Claude Code 通知プラグイン - 承認要求通知
#
# 権限承認が必要な場合に通知を送信する。
# トランスクリプトから最新の tool_use を取得し、
# 承認が必要なツールの情報を表示する。
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

check_dependencies

CLAUDE_MESSAGE=""
SUBTITLE=""

# stdin からフック JSON を読み込む
HOOK_JSON=$(read_hook_json)

# hook JSON が空の場合は終了
if [ -z "$HOOK_JSON" ]; then
    exit 0
fi

# トランスクリプトパスを取得
TRANSCRIPT_PATH=$(echo "$HOOK_JSON" | jq -r '.transcript_path // empty')

# トランスクリプトから最新の tool_use を抽出
TOOL_USE=""
TOOL_USE_LINE=$(search_transcript "$TRANSCRIPT_PATH" '"type":"tool_use"')
if [ -n "$TOOL_USE_LINE" ]; then
    # tool_use オブジェクトを抽出
    TOOL_USE=$(echo "$TOOL_USE_LINE" | jq -r '.message.content[] | select(.type == "tool_use")' 2>/dev/null || true)
fi

# tool_use が見つかった場合はフォーマット
if [ -n "$TOOL_USE" ]; then
    format_tool_message "$TOOL_USE"
else
    # フォールバック: フック JSON の .message フィールドを使用
    CLAUDE_MESSAGE=$(echo "$HOOK_JSON" | jq -r '.message // empty')
fi

# メッセージをフォーマット
if [ -n "$CLAUDE_MESSAGE" ]; then
    CLAUDE_MESSAGE=$(format_message "$CLAUDE_MESSAGE")
fi

# プロジェクト名を設定
PROJECT_NAME="${CLAUDE_PROJECT_DIR:-$PWD}"
PROJECT_NAME="${PROJECT_NAME##*/}"

# 通知を送信
send_notification \
    "[${PROJECT_NAME}] requires approval" \
    "${CLAUDE_MESSAGE:-Approval required}" \
    "Purr" \
    "$SUBTITLE"
