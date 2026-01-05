#!/bin/bash
#
# Claude Code 通知プラグイン - 依存関係チェック
#
# SessionStart フックで呼び出され、必要なコマンドがインストールされているかチェックする。
# 不足している場合のみメッセージを表示し、すべて揃っている場合は何も出力しない。
#

##############################################################################
# 依存コマンドのチェック
#
# terminal-notifier と jq が必要。
# インストールされていない場合はインストール方法を表示する。
# 終了コードは常に 0（セッション開始を妨げない）
##############################################################################

missing=()

if ! command -v terminal-notifier &> /dev/null; then
    missing+=("terminal-notifier")
fi

if ! command -v jq &> /dev/null; then
    missing+=("jq")
fi

# 不足しているコマンドがある場合はエラー終了
if [ ${#missing[@]} -gt 0 ]; then
    printf "[notify-macos] Required commands not found: %s\n" "${missing[*]}"
    printf "[notify-macos] Run: brew install %s\n" "${missing[*]}"
    exit 2
fi

exit 0
