# command-logger

Claude CodeのBashコマンド実行履歴を自動的にログファイルに記録するプラグインです．

## 概要

このプラグインは，Claude Codeが`bash`ツールを使用してコマンドを実行した後，その情報をキャッシュファイルに保存します．PostToolUseフックを利用して，コマンドの実行結果を含む詳細な情報をJSON Lines形式で記録します．

**注意**: このプラグインの動作には`jq`コマンドが必須です．事前にインストールしてください．

```bash
brew install jq
```

## 機能

- セッション開始時に依存関係をチェック（不足時のみ警告表示とインストール方法を案内）
- Bashコマンド実行後に自動的にログを記録
- 実行したコマンド，終了コード，実行時間などの詳細情報を保存
- JSON Lines (JSONL) 形式で出力するため，パースや分析が容易

## インストール方法

Claude Code内で`/plugin`コマンドを使用してインストールします：
```
/plugin install command-logger@mdonaka 
```

## 出力形式

ログはJSON Lines形式で出力されます．各行が1つのコマンド実行を表す独立したJSONオブジェクトです．

### 出力例

```json
{"timestamp":"2025-01-15T10:30:45Z","command":"git status","exit_code":0,"duration_ms":45,"has_stdout":true,"has_stderr":false,"session_id":"abc123","tool_use_id":"toolu_xyz","cwd":"/home/user/project"}
```

## 出力フィールド

| フィールド | 型 | 説明 |
|-----------|------|------|
| `timestamp` | string | コマンド実行時刻（ISO 8601形式，UTC） |
| `command` | string | 実行されたコマンド |
| `exit_code` | number/null | コマンドの終了コード |
| `duration_ms` | number/null | コマンドの実行時間（ミリ秒） |
| `has_stdout` | boolean | 標準出力があったかどうか |
| `has_stderr` | boolean | 標準エラー出力があったかどうか |
| `session_id` | string | Claude Codeのセッション識別子 |
| `tool_use_id` | string | ツール使用の識別子 |
| `cwd` | string | コマンド実行時のカレントディレクトリ |

## 出力先

ログファイルは以下の場所に保存されます：

```
./.claude/command_cache
```

作業ディレクトリ（`$PWD`）の`.claude`ディレクトリに保存されます．ディレクトリが存在しない場合は自動的に作成され，パーミッション700（所有者のみアクセス可能）が設定されます．

## フックタイプ

### check-deps（依存関係チェック）

セッション開始時（SessionStart フック）に実行され、`jq` がインストールされているかチェックします。

- **トリガー**: セッション開始時
- **動作**: 不足しているコマンドがある場合のみ警告メッセージを表示し、インストール方法を案内
- **出力例**:
  ```
  [command-logger] Required commands not found: jq
  [command-logger] Run: brew install jq
  ```

すべての依存関係が揃っている場合は何も出力しません。

### log-command（コマンドログ記録）

Bashコマンド実行後（PostToolUse フック）に実行され、コマンドの情報をログファイルに記録します。

- **トリガー**: Bashツール使用後
- **動作**: コマンド情報をJSON Lines形式でログファイルに追記

## ファイル構成

```
command-logger/
├── .claude-plugin/
│   └── plugin.json      # プラグインメタデータ
├── hooks/
│   └── hooks.json       # フック設定
├── scripts/
│   ├── check-deps.sh    # 依存関係チェック（SessionStart）
│   └── log-command.sh   # コマンドログ記録スクリプト
└── README.md            # このファイル
```

## ログの活用例

記録されたログを分析する例：

```bash
# 最近10件のコマンドを表示
tail -10 .claude/command_cache | jq .

# 失敗したコマンド（終了コードが0以外）を抽出
cat .claude/command_cache | jq 'select(.exit_code != 0 and .exit_code != null)'

# 特定のセッションのコマンドを抽出
cat .claude/command_cache | jq 'select(.session_id == "your-session-id")'

# コマンドの実行時間でソート（遅い順）
cat .claude/command_cache | jq -s 'sort_by(-.duration_ms)'
```
