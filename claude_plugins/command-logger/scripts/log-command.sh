#!/bin/bash

set -euo pipefail

# Bashツール実行後にコマンドをキャッシュに保存するスクリプト
# stdin から JSON 形式でツール情報が渡される
#
# PostToolUse フックから渡されるJSONの構造:
# {
#   "session_id": "...",
#   "tool_name": "bash",
#   "tool_input": { "command": "..." },
#   "tool_response": { "stdout": "...", "stderr": "...", "exit_code": 0, ... },
#   ...
# }

# jq の存在確認（必須）
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed." >&2
    echo "Please install jq: brew install jq (macOS) or apt-get install jq (Linux)" >&2
    exit 1
fi

# キャッシュファイルのパス（作業ディレクトリに保存）
CACHE_DIR="${PWD}/.claude"
CACHE_FILE="${CACHE_DIR}/command_cache"

# ディレクトリが存在しない場合は作成（パーミッションを制限）
mkdir -p "${CACHE_DIR}"
chmod 700 "${CACHE_DIR}"

# stdin から JSON を読み込む
INPUT=$(cat) || true

# 入力が空の場合は終了
if [[ -z "${INPUT}" ]]; then
    exit 0
fi

# ISO 8601形式のタイムスタンプを生成
TIMESTAMP=$(date -u '+%Y-%m-%dT%H:%M:%SZ')

# jq を使って入力JSONから直接出力JSONを生成（シェル変数を経由しない）
# コマンドが存在する場合のみ出力
jq -c --arg timestamp "${TIMESTAMP}" '
    select(.tool_input.command != null and .tool_input.command != "") |
    {
        timestamp: $timestamp,
        command: .tool_input.command,
        exit_code: (.tool_response.exit_code // .tool_response.exitCode // null),
        duration_ms: (.tool_response.duration_ms // .tool_response.durationMs // null),
        has_stdout: ((.tool_response.stdout // "") | length > 0),
        has_stderr: ((.tool_response.stderr // "") | length > 0),
        session_id: (.session_id // ""),
        tool_use_id: (.tool_use_id // ""),
        cwd: (.cwd // "")
    }
' <<< "${INPUT}" >> "${CACHE_FILE}" 2>/dev/null || true
