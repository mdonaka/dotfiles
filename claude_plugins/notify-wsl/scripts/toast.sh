#!/bin/bash
#
# Claude Code 通知プラグイン (WSL) - トースト通知スクリプト
#
# WSL環境からWindows PowerShellを呼び出してトースト通知を表示する。
# Windows.UI.Notifications APIを使用して通知を送信する。
#
# 使用方法:
#   toast.sh "メッセージ" "タイトル"
#
# 引数:
#   $1 = message - 通知のメッセージ本文 (必須)
#   $2 = title   - 通知のタイトル (必須)
#
# 戻り値:
#   0 = 成功
#   1 = エラー（引数不足、PowerShell実行失敗など）
#

# 引数チェック
if [ $# -lt 2 ]; then
    echo "Usage: $0 <message> <title>" >&2
    exit 1
fi

MESSAGE="$1"
TITLE="$2"

# PowerShellスクリプトを生成
# Windows.UI.Notifications APIを使用してトースト通知を送信
# - 引数を直接スクリプト内に埋め込む
# - 特殊文字のエスケープ処理を行う
# - XMLとして安全な形式で埋め込む

# PowerShell内で使用するため、シングルクォートをエスケープ
MESSAGE_ESCAPED="${MESSAGE//\'/\'\'}"
TITLE_ESCAPED="${TITLE//\'/\'\'}"

# PowerShellスクリプトを構築（引数を直接埋め込み）
# 段階的フォールバック戦略:
#   1. BurntToastモジュールの使用を試行（推奨パス）
#   2. モジュールがない場合は既存のネイティブ実装にフォールバック（互換パス）
POWERSHELL_SCRIPT=$(cat <<PSEOF
\$Message = '$MESSAGE_ESCAPED'
\$Title = '$TITLE_ESCAPED'

# エラーアクション設定
\$ErrorActionPreference = "Stop"

try {
    # BurntToastモジュールのインポートを試行
    Import-Module BurntToast -ErrorAction Stop

    # BurntToast使用パス: New-BurntToastNotificationによる実装
    # AppLogoパラメータは環境依存の問題を避けるため省略し、デフォルトアイコンを使用
    New-BurntToastNotification -Text \$Title, \$Message ``
        -Sound Default ``
        -ErrorAction Stop

    exit 0
} catch {
    # BurntToastモジュールが利用できない場合、ネイティブ実装にフォールバック
    # エラー情報: \$_
    try {
        # Windows Runtime型の読み込み
        [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
        [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
        [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

        # XML特殊文字のエスケープ
        \$EscapedMessage = [System.Security.SecurityElement]::Escape(\$Message)
        \$EscapedTitle = [System.Security.SecurityElement]::Escape(\$Title)

        # トースト通知のXML定義
        # duration="long": 通知を長時間表示（25秒）し、ユーザーが見逃しにくくする
        # scenario="reminder": リマインダーとして扱い、アクションセンターに残す
        \$xml = @"
<toast duration="long" scenario="reminder">
  <visual>
    <binding template="ToastGeneric">
      <text>\$EscapedTitle</text>
      <text>\$EscapedMessage</text>
    </binding>
  </visual>
  <audio src="ms-winsoundevent:Notification.Default" />
</toast>
"@

        # XML読み込みと通知の作成
        \$xmlDoc = New-Object Windows.Data.Xml.Dom.XmlDocument
        \$xmlDoc.LoadXml(\$xml)
        \$toast = New-Object Windows.UI.Notifications.ToastNotification \$xmlDoc

        # 通知の送信
        [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("Claude Code").Show(\$toast)

        exit 0
    } catch {
        Write-Error "Failed to send toast notification: \$_"
        exit 1
    }
}
PSEOF
)

# PowerShellを実行
# - WSL環境から powershell.exe を呼び出す
# - -ExecutionPolicy Bypass: スクリプト実行ポリシーを一時的に回避（通知機能に署名は不要）
# - -Command オプションでスクリプトを実行
if ! powershell.exe -ExecutionPolicy Bypass -NoProfile -NonInteractive -Command "$POWERSHELL_SCRIPT" 2>&1; then
    echo "Error: Failed to execute PowerShell toast notification" >&2
    exit 1
fi

exit 0
