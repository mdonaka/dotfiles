---
description: Markdownファイルに定義されたタスクを実行する
argument-hint: [markdown-file-path]
allowed-tools: Read, Write, Edit, Bash(*), Glob, Grep, Task, TodoWrite
---

# Markdownタスク実行

指定されたMarkdownファイル @$1 に記載されたタスクを実行する．

## タスク形式

Markdownファイル内のタスクは以下の形式で定義されている:
- `[]` - 未着手タスク
- `[-]` - 進行中タスク
- `[x]` - 完了タスク

## 実行手順

1. **タスクファイルの読み込み**
   - 指定されたMarkdownファイルを読み込む
   - タスク一覧を抽出し，依存関係を分析する

2. **task-orchestratorエージェントの起動**
   - Taskツールを使用してtask-orchestratorエージェントを起動
   - タスクファイルのパスと内容を渡す
   - サブエージェントtypeは `general-purpose` を使用

3. **進捗の追跡**
   - タスクの進捗をMarkdownファイルに記録する
   - タグのステータス変更を都度反映する

## エージェント構成

以下のエージェントを使い分ける:
- **task-orchestrator**: タスク全体を解釈し，適切なサブエージェントに指示
- **task-implementer**: 実際の実装作業を担当
- **task-reviewer**: コードレビューと品質チェックを担当

## 並列実行

- 独立したタスクはgit-worktreeを使用して並列実行可能
- 依存関係のあるタスクは順次実行

## 実行開始

task-orchestratorエージェントを起動し，以下を指示する:
- タスクファイル: $1
- 実行モード: レビューと実装を交互に行う
- 進捗記録: タスクファイルに作業メモを追記

Taskツールでgeneral-purposeサブエージェントを起動し，task-orchestratorとして動作させる．プロンプトには以下を含める:
- このプラグインのagents/task-orchestrator.mdの内容に従って動作すること
- タスクファイルのパス: $1
- タスクの実行と進捗管理を行うこと
