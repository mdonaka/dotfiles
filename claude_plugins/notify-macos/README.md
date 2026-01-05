# notify-macos

**macOS専用** - Claude Codeのタスク完了時や承認要求時にmacOS通知を送信するプラグインです．

## 概要

このプラグインは，Claude Codeがタスクを完了した時（Stopフック）や，ユーザーの承認を必要とする時（Notificationフック）にmacOSのデスクトップ通知を送信します．通知には実行中のツール情報やClaudeからのメッセージが含まれます．

## 動作要件

- **macOS** (Linux/Windowsでは動作しません)
- `terminal-notifier` - macOSネイティブ通知の送信に必要
- `jq` - JSONパースに必要

**注意**: このプラグインの動作には`terminal-notifier`と`jq`コマンドが必須です．事前にインストールしてください．

```bash
brew install terminal-notifier jq
```

## 機能

- セッション開始時に依存関係をチェック（不足時のみ警告表示）
- タスク完了時に通知を送信（サウンド: Blow）
- 承認要求時に通知を送信（サウンド: Purr）
- 実行中のツール情報（コマンド，ファイルパス，検索パターンなど）を通知に表示
- プロジェクト名を通知タイトルに含める

## インストール方法

Claude Code内で`/plugin`コマンドを使用してインストールします：
```
/plugin install notify-macos@nakata
```

## フックタイプ

### check-deps（依存関係チェック）

セッション開始時（SessionStart フック）に実行され、`terminal-notifier` と `jq` がインストールされているかチェックします。

- **トリガー**: セッション開始時
- **動作**: 不足しているコマンドがある場合のみ警告メッセージを表示し、インストール方法を案内
- **出力例**:
  ```
  [notify-macos] Required commands not found: terminal-notifier jq
  [notify-macos] Run: brew install terminal-notifier jq
  ```

すべての依存関係が揃っている場合は何も出力しません。

### complete（タスク完了）

タスクが完了した際に送信される通知です．

- **タイトル**: `[プロジェクト名] complete`
- **メッセージ**: Claudeからの最後のアシスタントメッセージ
- **サウンド**: Blow

### approval（承認要求）

ユーザーの承認が必要な操作を実行する際に送信される通知です．

- **タイトル**: `[プロジェクト名] requires approval`
- **メッセージ**: 実行しようとしているツールの情報
- **サウンド**: Purr

## サポートされるツール表示

承認要求時には，以下のツールの情報が分かりやすく表示されます：

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
notify-macos/
├── .claude-plugin/
│   └── plugin.json      # プラグインメタデータ
├── hooks/
│   └── hooks.json       # フック設定
├── scripts/
│   ├── common.sh        # 共通関数
│   ├── check-deps.sh    # 依存関係チェック（SessionStart）
│   ├── complete.sh      # タスク完了通知
│   └── approval.sh      # 承認要求通知
└── README.md            # このファイル
```
