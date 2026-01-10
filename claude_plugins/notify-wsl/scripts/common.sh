#!/bin/bash
#
# Claude Code 通知プラグイン (WSL) - 共通関数
#
# このファイルは他のスクリプトから source されることを想定している。
# 通知送信に必要な共通機能を提供する。
#

# スクリプトディレクトリのパスを取得（sourceされることを想定）
# SCRIPT_DIRが未定義の場合のみ設定（呼び出し元が既に定義している可能性があるため）
if [ -z "${SCRIPT_DIR:-}" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

##############################################################################
# stdin から hook JSON を読み込む関数
#
# ターミナルでない場合（パイプ入力がある場合）に stdin から JSON を読み込む。
#
# 出力:
#   読み込んだ JSON 文字列を標準出力に出力
##############################################################################

read_hook_json() {
    if [ ! -t 0 ]; then
        cat
    fi
}

##############################################################################
# トランスクリプトを検索する関数
#
# トランスクリプトファイルの最後の5行を逆順で読み、
# 指定されたパターンにマッチする最初の行を返す。
#
# 引数:
#   $1 = transcript_path - トランスクリプトファイルのパス
#   $2 = pattern         - 検索する grep パターン
#
# 出力:
#   マッチした行を標準出力に出力（マッチしない場合は空）
##############################################################################

search_transcript() {
    local transcript_path="$1"
    local pattern="$2"

    if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
        # WSLではtail -rの代わりにtac（逆順cat）を使用
        tail -n 5 "$transcript_path" | tac | grep -m 1 "$pattern" || true
    fi
}

##############################################################################
# ツール情報をフォーマットする関数
#
# 主要ケースにのみ対応。Claude Code のツール使用情報から
# 人間が読みやすい形式のメッセージを生成する。
#
# 引数:
#   $1 = tool_use JSON (jq で解析可能な JSON 文字列)
#
# 出力:
#   CLAUDE_MESSAGE - メイン通知メッセージ (グローバル変数)
#   SUBTITLE       - サブタイトル (グローバル変数、オプション)
##############################################################################

format_tool_message() {
    local tool_json="$1"
    local tool_name
    tool_name=$(echo "$tool_json" | jq -r '.name // empty')

    case "$tool_name" in
        Bash)
            local cmd desc
            cmd=$(echo "$tool_json" | jq -r '.input.command // empty')
            desc=$(echo "$tool_json" | jq -r '.input.description // empty')
            CLAUDE_MESSAGE="$ ${cmd}"
            [ -n "$desc" ] && SUBTITLE="→ ${desc}"
            ;;
        Write|Edit|Read)
            local file_path
            file_path=$(echo "$tool_json" | jq -r '.input.file_path // empty')
            CLAUDE_MESSAGE="${tool_name}: ${file_path##*/}"
            ;;
        Glob)
            local pattern
            pattern=$(echo "$tool_json" | jq -r '.input.pattern // empty')
            CLAUDE_MESSAGE="Glob: ${pattern}"
            ;;
        Grep)
            local pattern
            pattern=$(echo "$tool_json" | jq -r '.input.pattern // empty')
            CLAUDE_MESSAGE="Grep: ${pattern}"
            ;;
        WebFetch)
            local url
            url=$(echo "$tool_json" | jq -r '.input.url // empty')
            CLAUDE_MESSAGE="WebFetch: ${url}"
            ;;
        WebSearch)
            local query
            query=$(echo "$tool_json" | jq -r '.input.query // empty')
            CLAUDE_MESSAGE="WebSearch: ${query}"
            ;;
        Task)
            local desc
            desc=$(echo "$tool_json" | jq -r '.input.description // empty')
            CLAUDE_MESSAGE="Task: ${desc}"
            ;;
        *)
            CLAUDE_MESSAGE="Tool: ${tool_name}"
            ;;
    esac
}

##############################################################################
# メッセージをフォーマットする関数
#
# 連続する空白を単一スペースに変換し、
# 200文字を超える場合は末尾を "..." で省略する。
#
# 引数:
#   $1 = フォーマット対象の文字列
#
# 出力:
#   フォーマット済みの文字列を標準出力に出力
##############################################################################

format_message() {
    local message="$1"
    local max_length=200

    # 連続する空白文字（スペース、タブ、改行）を単一スペースに変換
    message=$(printf '%s' "$message" | tr -s '[:space:]' ' ')

    # 先頭と末尾の空白を除去
    message=$(printf '%s' "$message" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # 200文字を超える場合は省略
    if [ ${#message} -gt $max_length ]; then
        message="${message:0:$max_length}..."
    fi

    printf '%s' "$message"
}

##############################################################################
# 通知を送信する関数
#
# toast.sh を使用して Windows トースト通知を送信する。
#
# 引数:
#   $1 = title    - 通知のタイトル (必須)
#   $2 = message  - 通知のメッセージ本文 (必須)
#   $3 = sound    - 通知音の名前 (オプション、デフォルト: Default)
#                   利用可能な値: Default, IM, Mail, Reminder, SMS, Alarm
#   $4 = subtitle - サブタイトル (オプション、メッセージに追加)
#
# 戻り値:
#   toast.sh の終了コード
##############################################################################

send_notification() {
    local title="$1"
    local message="$2"
    local sound="${3:-Default}"
    local subtitle="${4:-}"

    # サブタイトルがある場合はメッセージに追加
    if [ -n "$subtitle" ]; then
        message="${subtitle}\n${message}"
    fi

    # toast.shのパスを決定（プラグインディレクトリ内）
    local toast_script="${SCRIPT_DIR}/toast.sh"

    if [ -f "$toast_script" ]; then
        "$toast_script" "$message" "$title" "$sound"
    else
        # フォールバックとして標準エラー出力に警告
        echo "[notify-wsl] Warning: toast.sh not found at $toast_script" >&2
        echo "[notify-wsl] Expected location: plugin directory" >&2
        return 1
    fi
}
