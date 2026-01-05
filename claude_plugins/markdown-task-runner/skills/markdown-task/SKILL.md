---
name: markdown-task
description: This skill should be used when the user asks to "run markdown tasks", "execute task file", "parse task format", "understand task tags", or needs guidance on markdown task file format, task status tags ([], [-], [x]), task hierarchy, or progress tracking in markdown files.
version: 1.0.0
---

# Markdown Task Format Skill

Markdownファイルでタスクを定義・管理するためのフォーマットに関するスキル．

## タスク形式

タスクは以下のタグで状態を表現:
- `[]` - 未着手タスク
- `[-]` - 進行中タスク
- `[x]` - 完了タスク

## 基本構文

```markdown
# Task
[] メインタスク1
  [] サブタスク1-1
  [] サブタスク1-2
[] メインタスク2
```

## 階層構造

インデント（2スペース）でタスクの階層を表現:

```markdown
[] 親タスク
  [] 子タスク
    [] 孫タスク
```

親タスクは全ての子タスクが完了したら完了とする．

## 進捗記録

タスクの下に作業ログを記録:

```markdown
[-] 機能Xを実装する
  [x] 設計
  [-] コーディング
  [] テスト

### 作業ログ
#### YYYY-MM-DD HH:MM - 作業内容
- 実行したコマンド
- 作成したファイル
- 備考
```

## タスク解析ルール

### タスク行の識別

正規表現: `^\s*\[([ x-])\]\s+(.+)$`
- グループ1: ステータス（空白=未着手, -=進行中, x=完了）
- グループ2: タスク内容

### 階層レベルの判定

先頭スペース数 / 2 = 階層レベル
- 0スペース: レベル0（ルート）
- 2スペース: レベル1
- 4スペース: レベル2

### 依存関係

- 同階層の先行タスクが完了していない場合，そのタスクは依存あり
- 子タスクは親タスクに依存

## ステータス更新規則

1. タスク開始時: `[]` → `[-]`
2. タスク完了時: `[-]` → `[x]`
3. 全子タスク完了時: 親タスクを `[x]` に更新

## 作業ログのフォーマット

```markdown
#### YYYY-MM-DD HH:MM - {作業タイトル}
- {実行内容1}
- {実行内容2}
```bash
{実行したコマンド}
```
{備考や結果}
```

## タスクファイルの構造例

```markdown
# 概要
{プロジェクトの説明}

# Task
[] タスク1
  [] サブタスク1-1
  [] サブタスク1-2
[] タスク2
  [] サブタスク2-1

# 作業ログ
{自動的に追記される作業記録}
```

## Additional Resources

### Reference Files

詳細なフォーマット仕様については:
- **`references/format.md`** - 完全なフォーマット仕様
