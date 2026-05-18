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

# 依存関係がない場合は静かに終了（SessionStartでチェック済み）
command -v terminal-notifier &> /dev/null || exit 0
command -v jq &> /dev/null || exit 0

CLAUDE_MESSAGE=""
SUBTITLE=""

# stdin からフック JSON を読み込む
HOOK_JSON=$(read_hook_json)

# hook JSON が空の場合は終了
if [ -z "$HOOK_JSON" ]; then
    exit 0
fi

# hook_event_name で発火経路を分岐
HOOK_EVENT_NAME=$(echo "$HOOK_JSON" | jq -r '.hook_event_name // ""')

if [ "$HOOK_EVENT_NAME" = "PreToolUse" ]; then
    # ユーザー入力を要するツール（AskUserQuestion等）の事前通知
    TOOL_NAME=$(echo "$HOOK_JSON" | jq -r '.tool_name // ""')
    case "$TOOL_NAME" in
        AskUserQuestion)
            TITLE_SUFFIX="needs your input"
            CLAUDE_MESSAGE=$(echo "$HOOK_JSON" | jq -r '.tool_input.questions[0].question // empty')
            ;;
        *)
            TITLE_SUFFIX="needs attention"
            CLAUDE_MESSAGE="Tool: ${TOOL_NAME}"
            ;;
    esac
else
    # PermissionRequest: 権限ダイアログ出現時に発火
    TITLE_SUFFIX="requires approval"
    TOOL_NAME=$(echo "$HOOK_JSON" | jq -r '.tool_name // ""')
    TOOL_USE=$(echo "$HOOK_JSON" | jq -c '{name: .tool_name, input: .tool_input}')
    if [ -n "$TOOL_NAME" ]; then
        format_tool_message "$TOOL_USE"
    fi
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
    "[${PROJECT_NAME}] ${TITLE_SUFFIX}" \
    "${CLAUDE_MESSAGE:-Action required}" \
    "Purr" \
    "$SUBTITLE"
