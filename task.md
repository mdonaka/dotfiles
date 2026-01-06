# 概要

markdown-task-runnerプラグインの改修タスク

# Task

[x] フェーズのループ構造を改善する - 設計→実装→レビュー→(差し戻しなら)実装→レビュー...の繰り返しを一区切りとし、次のタスクで再度設計フェーズに戻るフローにするため
  [x] 設計
  [x] commands/task.mdのループ構造を改修する - コアロジックの変更
  [x] task-implementer.mdのコミット規約を更新する - 中間コミットと最終コミットの区別
  [x] README.mdのワークフロー説明を更新する - 新しいループ構造の図と説明
[] task-designerにタスク細分化機能を追加し、main sessionがタスクmdを整理する仕組みを作る - 設計フェーズでの適切なタスク分解のため
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

