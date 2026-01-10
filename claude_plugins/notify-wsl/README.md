# notify-wsl

**WSL専用** - Claude Codeのタスク完了時や承認要求時にWindowsトースト通知を送信するプラグインです。

## 概要

このプラグインは、Claude Codeがタスクを完了した時（Stopフック）や、ユーザーの承認を必要とする時（Notificationフック）にWindowsのデスクトップ通知を送信します。通知には実行中のツール情報やClaudeからのメッセージが含まれます。

## 動作要件

- **WSL** (Windows Subsystem for Linux)
- `jq` - JSONパースに必要
- `powershell.exe` - Windows通知APIの呼び出しに必要
- `wslpath` - WSL/Windowsパス変換に必要

**注意**: このプラグインの動作には`jq`が必須です。事前にインストールしてください。

```bash
# jqのインストール
sudo apt-get install jq
```

## 機能

- セッション開始時に依存関係をチェック（不足時のみ警告表示）
- タスク完了時にWindowsトースト通知を送信
- 承認要求時にWindowsトースト通知を送信
- 実行中のツール情報（コマンド、ファイルパス、検索パターンなど）を通知に表示
- プロジェクト名を通知タイトルに含める

## インストール方法

Claude Code内で`/plugin`コマンドを使用してインストールします：
```
/plugin install notify-wsl@nakata
```

またはローカルディレクトリから直接インストール：
```
/plugin install /path/to/dotfiles/claude_plugins/notify-wsl
```

## フックタイプ

### check-deps（依存関係チェック）

セッション開始時（UserPromptSubmit フック）に実行され、`jq`、`powershell.exe`、`wslpath`、および`toast.sh`が利用可能かチェックします。

- **トリガー**: ユーザープロンプト送信時
- **動作**: 不足しているコマンドやファイルがある場合、エラーメッセージを表示し、セッションを継続
- **出力例**:
  ```
  [notify-wsl] Required commands not found: jq
  [notify-wsl] Run: sudo apt-get install jq
  ```

すべての依存関係（コマンドおよびtoast.sh）が揃っている場合は何も出力しません。

### complete（タスク完了）

タスクが完了した際に送信される通知です。

- **タイトル**: `[プロジェクト名] complete`
- **メッセージ**: Claudeからの最後のアシスタントメッセージ

### approval（承認要求）

ユーザーの承認が必要な操作を実行する際に送信される通知です。

- **タイトル**: `[プロジェクト名] requires approval`
- **メッセージ**: 実行しようとしているツールの情報

## サポートされるツール表示

承認要求時には、以下のツールの情報が分かりやすく表示されます：

| ツール | 表示形式 |
|--------|----------|
| Bash | `$ コマンド` （説明がある場合はサブタイトルに表示） |
| Write/Edit/Read | `ツール名: ファイル名` |
| Glob | `Glob: パターン` |
| Grep | `Grep: パターン` |
| WebFetch | `WebFetch: URL` |
| WebSearch | `WebSearch: クエリ` |
| Task | `Task: 説明` |
| その他 | `Tool: ツール名` |

## ファイル構成

```
notify-wsl/
├── .claude-plugin/
│   └── plugin.json      # プラグインメタデータ
├── hooks/
│   └── hooks.json       # フック設定
├── scripts/
│   ├── common.sh        # 共通関数
│   ├── check-deps.sh    # 依存関係チェック（UserPromptSubmit）
│   ├── complete.sh      # タスク完了通知
│   ├── approval.sh      # 承認要求通知
│   └── toast.sh         # Windowsトースト通知スクリプト
└── README.md            # このファイル
```

## toast.shについて

このプラグインは内部に含まれている`toast.sh`スクリプトを使用してWindowsトースト通知を表示します。`toast.sh`はプラグインと一緒にインストールされるため、別途配置する必要はありません。

プラグイン内部での配置場所：
- `scripts/toast.sh`

`toast.sh`の基本的な使い方：
```bash
./toast.sh "メッセージ" "タイトル"
```

## トラブルシューティング

### 通知が表示されない

1. 依存関係チェックでエラーが表示されていないか確認
2. WSL上でPowerShellが利用可能か確認（`powershell.exe -Command "Write-Host test"`）

### 依存関係エラー

プラグインを初めて使用する際にエラーが表示された場合：
```bash
# jqをインストール
sudo apt-get update && sudo apt-get install jq
```

### 実行権限エラー

スクリプトの実行権限が不足している場合（"Permission denied"エラー）：
```bash
# プラグインディレクトリに移動
cd ~/.claude/plugins/notify-wsl/

# 実行権限を付与
chmod +x scripts/*.sh
```

## ライセンス

このプラグインはMITライセンスの下で公開されています。
