---
name: process-task-md
description: Use when the user references a markdown file containing task instructions, says "mdを処理して", "タスクファイルを実行して", or opens a task file like to_claude.md and asks to process it. Also use when user provides a markdown file with sections like "対象ディレクトリ", "タスク", or structured task instructions.
---

# タスクMarkdown処理

markdownファイルに書かれたタスク指示を読み取り、superpowersのワークフローに従って実行する。

## When to Use

- ユーザーがmarkdownファイルを指定して「処理して」「実行して」と言った時
- `to_claude.md` や `task.md` のようなタスク指示ファイルを参照された時
- markdownに「対象ディレクトリ」「タスク」等の構造化された指示が含まれている時

**NOT:** 単純な質問、コードレビュー、コミット作業など既存スキルがカバーする作業

## Core Pattern

```
ファイル読み取り → 構造抽出 → superpowersワークフロー → 実行
```

## ワークフロー

| ステップ | 内容 |
|---------|------|
| 1. 読み取り | 指定されたmdファイルをReadで読む |
| 2. 構造抽出 | 対象ディレクトリ、タスク、テンプレートを把握 |
| 3. brainstorm | **REQUIRED:** superpowers:brainstorming でタスクを分解・整理 |
| 4. 計画 | **REQUIRED:** superpowers:writing-plans で実装計画を作成 |
| 5. 実行 | 計画に基づいて実行（下記の実行方法を参照） |
| 6. 確認 | **REQUIRED:** superpowers:verification-before-completion で成果物を検証 |

## 実行方法の選択

ステップ5の実行方法はタスクの規模で判断する：

```
タスクは1つで単純？ → 直接実行
独立した複数タスク？ → superpowers:dispatching-parallel-agents で並列サブエージェント実行
順序依存のある複数タスク？ → superpowers:subagent-driven-development で逐次サブエージェント実行（タスクごとにレビュー付き）
大規模で協調が必要？ → TeamCreateでエージェントチームを作成して遂行
```

## Common Mistakes

| ミス | 対策 |
|------|------|
| brainstormせずに即実行 | 必ずsuperpowers:brainstormingを経由する |
| 計画なしにコードを書く | superpowers:writing-plansで計画を立てる |
| テンプレートやサンプルを無視 | mdに記載されたフォーマットに従う |
| 対象ディレクトリ外を変更 | 指定されたディレクトリのみを対象にする |
| 成果物の検証をスキップ | superpowers:verification-before-completionで必ず確認 |

## Worktree

- このプラグインの開発作業は必ずworktreeで行うこと
- worktreeディレクトリ: `.worktrees/`
