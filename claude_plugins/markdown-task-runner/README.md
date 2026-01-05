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

## アーキテクチャ

Claude Codeではサブエージェントからサブエージェントを呼び出せないため，メインセッション（`/task` コマンド）が直接オーケストレーションを行う．

```
メインセッション (/task コマンド)
    │
    ├── task-designer     設計・分析
    │
    ├── task-implementer  実装
    │
    └── task-reviewer     レビュー
```

## 機能

- **メインセッション**: タスク解析とサブエージェントへの指示（オーケストレーション）
- **task-designer**: 要件分析と設計方針の策定
- **task-implementer**: コーディングを担当
- **task-reviewer**: コードレビューと品質チェック
- **git-worktree**: 独立タスクの並列実行
- **自動ログ**: タスクファイルへの作業記録

## エージェント構成

| エージェント | サブエージェントtype | 役割 |
|---|---|---|
| task-designer | `markdown-task-runner:task-designer` | 要件分析，設計方針策定，タスク分解 |
| task-implementer | `markdown-task-runner:task-implementer` | 実際のコーディング |
| task-reviewer | `markdown-task-runner:task-reviewer` | 実装のレビューと品質チェック |

## ワークフロー

```
設計（必要に応じて） → 実装 → レビュー → 修正 → 完了
```

独立したタスクはgit-worktreeで並列実行可能．
