# markdown-task-runner

Markdownファイルに定義されたタスクをサブエージェントで並列実行するワークフロー管理プラグイン

## インストール

```bash
/plugin install markdown-task-runner@mdonaka
```

## 使い方

```bash
/task path/to/tasks.md
```

## タスクファイル形式

```markdown
# Task
[] メインタスク
  [] サブタスク1
  [] サブタスク2
```

### タグ
- `[]` - 未着手
- `[-]` - 進行中
- `[x]` - 完了

## 機能

- **task-orchestrator**: タスク解析とサブエージェントへの指示
- **task-designer**: 要件分析と設計方針の策定
- **task-implementer**: コーディングを担当
- **task-reviewer**: コードレビューと品質チェック
- **git-worktree**: 独立タスクの並列実行
- **自動ログ**: タスクファイルへの作業記録

## エージェント構成

1. **task-orchestrator** - タスクを解釈し，各エージェントに作業を割り振る
2. **task-designer** - 要件分析，設計方針策定，タスク分解を担当
3. **task-implementer** - 実際のコーディングを担当
4. **task-reviewer** - 実装のレビューと品質チェックを担当

## ワークフロー

```
設計（必要に応じて） → 実装 → レビュー → 修正 → 完了
```

独立したタスクはgit-worktreeで並列実行可能．
