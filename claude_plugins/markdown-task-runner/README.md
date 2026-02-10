# markdown-task-runner

Markdownファイルに定義されたタスク指示をsuperpowersワークフローで実行するプラグインです．

## 概要

このプラグインは，Markdownファイルに記載されたタスク指示を読み取り，superpowersのワークフロー（brainstorm → 計画 → 実行 → 検証）に従って自動的に実行します．タスクの規模に応じて，直接実行・並列サブエージェント・逐次サブエージェント・エージェントチームから最適な実行方法を選択します．

## 機能

- Markdownファイルからタスク指示を構造的に抽出
- superpowersワークフローに沿った段階的な実行（brainstorm → 計画 → 実行 → 検証）
- タスク規模に応じた実行方法の自動選択

## インストール方法

Claude Code内で`/plugin`コマンドを使用してインストールします：
```
/plugin install markdown-task-runner@mdonaka
```

## 使い方

タスクが記載されたMarkdownファイルを指定して実行します：

```
mdを処理して: path/to/task.md
タスクファイルを実行して: to_claude.md
```

### トリガーとなるフレーズ

- 「mdを処理して」
- 「タスクファイルを実行して」
- `to_claude.md` や `task.md` のようなタスク指示ファイルを参照

### ワークフロー

```
ファイル読み取り → 構造抽出 → brainstorm → 計画 → 実行 → 検証
```

### 実行方法の選択

タスクの規模に応じて実行方法が自動的に選択されます：

| 規模 | 実行方法 |
|------|----------|
| 単一タスク | 直接実行 |
| 独立した複数タスク | `superpowers:dispatching-parallel-agents` で並列サブエージェント実行 |
| 順序依存のある複数タスク | `superpowers:subagent-driven-development` で逐次サブエージェント実行（レビュー付き） |
| 大規模で協調が必要 | `TeamCreate` でエージェントチームを作成して遂行 |

## ファイル構成

```
markdown-task-runner/
├── .claude-plugin/
│   └── plugin.json         # プラグインメタデータ
├── skills/
│   └── markdown-task/
│       └── SKILL.md        # スキル定義
└── README.md               # このファイル
```
