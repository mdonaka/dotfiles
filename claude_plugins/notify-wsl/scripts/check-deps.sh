#!/bin/bash
#
# Claude Code 通知プラグイン (WSL) - 依存関係チェック
#
# UserPromptSubmit フックで呼び出され、必要なコマンドがインストールされているかチェックする。
# 不足している場合のみメッセージを表示し、すべて揃っている場合は何も出力しない。
#

##############################################################################
# 依存コマンドのチェック
#
# jq、powershell.exe、wslpath、toast.sh が必要。
# インストールされていない場合はインストール方法を表示する。
# 終了コードは常に 0（セッション開始を妨げない）
##############################################################################

missing=()

if ! command -v jq &> /dev/null; then
    missing+=("jq")
fi

if ! command -v powershell.exe &> /dev/null; then
    missing+=("powershell.exe")
fi

if ! command -v wslpath &> /dev/null; then
    missing+=("wslpath")
fi

# toast.shの存在チェック
TOAST_SCRIPT="${DOTFILES_ROOT:-$HOME/dotfiles}/toast.sh"
if [ ! -f "$TOAST_SCRIPT" ]; then
    printf "[notify-wsl] toast.sh not found at: %s\n" "$TOAST_SCRIPT" >&2
    printf "[notify-wsl] Please ensure toast.sh is in your dotfiles directory\n" >&2
    exit 2
fi

# 不足しているコマンドがある場合はエラー終了
if [ ${#missing[@]} -gt 0 ]; then
    printf "[notify-wsl] Required commands not found: %s\n" "${missing[*]}" >&2
    if [[ " ${missing[*]} " =~ " jq " ]]; then
        printf "[notify-wsl] Run: sudo apt-get install jq\n" >&2
    fi
    exit 2
fi

exit 0
