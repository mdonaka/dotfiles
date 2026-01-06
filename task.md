# 概要

markdown-task-runnerプラグインの改修タスク

# Task

[x] フェーズのループ構造を改善する - 設計→実装→レビュー→(差し戻しなら)実装→レビュー...の繰り返しを一区切りとし、次のタスクで再度設計フェーズに戻るフローにするため
  [x] 設計
  [x] commands/task.mdのループ構造を改修する - コアロジックの変更
  [x] task-implementer.mdのコミット規約を更新する - 中間コミットと最終コミットの区別
  [x] README.mdのワークフロー説明を更新する - 新しいループ構造の図と説明
[x] task-designerにタスク細分化機能を追加し、main sessionがタスクmdを整理する仕組みを作る - 設計フェーズでの適切なタスク分解のため
  [x] 設計
  [x] task-designer.mdに構造化出力フォーマットを追加する - ```taskブロックを報告フォーマットに含める
  [x] commands/task.mdにタスクファイル更新処理を追加する - 設計フェーズ完了後のサブタスク挿入ロジック
[] agentsの情報を取捨選択して整理する - 不要な情報を削減し、エージェントの効率を向上させるため
[] skillsの情報を整理する - 同様に不要な情報を削減するため

# 作業ログ

#### 2026-01-06 - フェーズのループ構造改善完了
- task-designerで設計完了
- task-implementerでcommands/task.md, task-implementer.md, README.mdを改修
- task-reviewerで1回目レビュー: 要修正（Major Issues 2件）
- task-implementerで修正実施
- task-reviewerで2回目レビュー: 承認

変更内容:
- 設計フェーズはタスク開始時に1回のみ実行
- 実装・レビューは承認されるまでループ
- コミットはレビュー承認後にメインセッションが作成
- 3ファイル間でワークフロー記述を統一

#### 2026-01-06 - タスク細分化機能追加完了
- task-designerで設計完了
- task-implementerで並列実行（task-designer.md, commands/task.md）
- task-reviewerで1回目レビュー: 要修正（Major Issues 3件）
  - インデント仕様の矛盾
  - 既存サブタスク処理の曖昧さ
  - 「設計」タスクの特殊処理の一貫性欠如
- task-implementerで修正実施
- task-reviewerで2回目レビュー: 承認

変更内容:
- task-designer.mdに構造化タスク出力（```taskブロック）フォーマットを追加
- commands/task.mdにタスクファイル更新処理（3.1.1セクション）を追加
- 相対的なインデント構造の保持、既存サブタスクとの統合ルールを明確化

