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

## アーキテクチャ

**重要**: Claude Codeではサブエージェントからサブエージェントを呼び出せないため，メインセッション（このコマンド）が直接オーケストレーションを行う．

```
メインセッション (/task)
    ├── task-designer (設計フェーズ)
    ├── task-implementer (実装フェーズ)
    └── task-reviewer (レビューフェーズ)
```

## 実行手順

### 1. タスクファイルの読み込みと解析

1. 指定されたMarkdownファイルを読み込む
2. タスク一覧を抽出（`[]`, `[-]`, `[x]` タグを解析）
3. タスクの階層構造を把握（インデントで判断）
4. 依存関係を分析

### 2. 実行計画の策定

- 独立したタスク: 並列実行可能 → git-worktreeで別ブランチ
- 依存タスク: 順次実行
- 複雑なタスク: 設計フェーズを先に実行

### 3. タスク実行ループ

未完了タスクがある限り以下を繰り返す:

#### 3.1 設計フェーズ（複雑なタスクの場合）

Taskツールで `markdown-task-runner:task-designer` サブエージェントを起動:

```
以下のタスクの設計を行ってください．

【タスク】
{タスク内容}

【コンテキスト】
- 作業ディレクトリ: {path}
- 関連ファイル: {files}

【期待される成果】
- 要件分析結果
- 設計方針
- 実装タスクへの分解
```

#### 3.2 実装フェーズ

Taskツールで `markdown-task-runner:task-implementer` サブエージェントを起動:

```
以下のタスクを実装してください．

【タスク】
{タスク内容}

【コンテキスト】
- 作業ディレクトリ: {path}
- 関連ファイル: {files}

【期待される成果】
- {deliverables}

【注意事項】
- コードを書く際はTDDを意識
- 完了したら成果物の概要を報告
- 適切なタイミングでコミットを作成
```

#### 3.3 レビューフェーズ

実装完了後，Taskツールで `markdown-task-runner:task-reviewer` サブエージェントを起動:

```
以下の実装をレビューしてください．

【レビュー対象】
{実装内容の概要}

【変更ファイル】
{changed files}

【レビュー観点】
- コード品質
- バグの可能性
- セキュリティ
- テストカバレッジ

【期待するアウトプット】
- 問題点のリスト（重要度付き）
- 改善提案
- 承認/差し戻しの判断
```

#### 3.4 修正フェーズ（差し戻しの場合）

レビューで指摘があれば，再度 `task-implementer` を起動して修正．

### 4. 進捗記録

各フェーズ完了後，タスクファイルを更新:
- タグステータスの更新（`[]` → `[-]` → `[x]`）
- 作業ログの追記

## git-worktree並列実行

独立したタスクを並列実行する場合:

```bash
# worktree作成
git worktree add ../task-branch-1 -b task/feature-1
git worktree add ../task-branch-2 -b task/feature-2

# 複数のサブエージェントを並列起動（run_in_background: true）
# TaskOutputで完了を待機

# 完了後，マージ
git checkout main
git merge task/feature-1
git merge task/feature-2

# worktree削除
git worktree remove ../task-branch-1
git worktree remove ../task-branch-2
```

## 進捗更新の形式

```markdown
[-] 新しい機能を追加する
  [x] 設計
  [-] 実装
  [] テスト

### 作業ログ

#### YYYY-MM-DD HH:MM - 実装開始
- task-implementerサブエージェントで実装
- 作成ファイル: src/feature.ts

#### YYYY-MM-DD HH:MM - レビュー完了
- task-reviewerサブエージェントでレビュー
- 指摘: エラーハンドリングの追加が必要
```

## 実行開始

タスクファイル @$1 を読み込み，上記の実行手順に従ってタスクを順次実行する．

**注意**: サブエージェントの起動には以下のsubagent_typeを使用:
- 設計: `markdown-task-runner:task-designer`
- 実装: `markdown-task-runner:task-implementer`
- レビュー: `markdown-task-runner:task-reviewer`
