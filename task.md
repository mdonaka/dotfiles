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
[x] agentsの情報を取捨選択して整理する - 不要な情報を削減し、エージェントの効率を向上させるため
  [x] 設計
  [x] task-designer.mdを最適化する - 232行から85行に削減
  [x] task-implementer.mdを最適化する - 128行から51行に削減
  [x] task-reviewer.mdを最適化する - 176行から79行に削減
[x] skillsの情報を整理する - 同様に不要な情報を削減するため → 対象なしのため完了
  [x] 設計 - skillsディレクトリは存在しないことを確認
[x] タスクで「タスク-理由」の理由はいらない
  [x] 設計
  [x] commands/task.mdのタスク形式ガイドを修正する
    [x] 「タスクの書き方」セクションから理由形式の説明と例を削除
    [x] サブタスク抽出の例から理由部分を削除
    [x] 設計前後の例から理由部分を削除
  [x] agents/task-designer.mdのフォーマット仕様を修正する
    [x] フォーマット仕様のサンプルから理由部分を削除
    [x] 説明の記述方法の項目を削除
    [x] 使用例から理由部分を削除
[x] agentsは適切なものを用いるようにし，無い場合にtask-implementer.mdを用いるようにする
  [x] 設計
  [x] commands/task.mdにエージェント選択ロジックを追加する
    [x] 実装フェーズでのエージェント選択ルールをセクションとして記述する
    [x] 利用可能なエージェントの探索手順を記述する
    [x] マッチング基準（エージェント名・descriptionベース）を記述する
    [x] デフォルトエージェント（task-implementer）へのフォールバックを記述する

# 作業ログ

#### 2026-01-06 - エージェント選択ロジック追加完了
- task-designerで設計実施
- task-implementerでcommands/task.mdにエージェント選択セクションを追加
- task-reviewerで1回目レビュー: 要修正（Major Issues 3件）
  - 疑似コードの論理エラー
  - description_keywordsの未定義
  - マッチング基準の曖昧さ
- task-implementerで修正実施
- task-reviewerで2回目レビュー: 承認

変更内容:
- セクション3.2.1「エージェント選択」を新設
- 専門エージェントの探索・マッチングロジックを定義
- task-implementerをデフォルトフォールバックとして設定

#### 2026-01-06 - タスク形式から理由部分を削除完了
- task-designerで設計実施
- task-implementerでcommands/task.md, agents/task-designer.mdを修正
- task-reviewerでレビュー: 承認

変更内容:
- 「タスク - 理由」形式を「タスク」のみの形式に変更
- タスク名自体に目的を含める方針に統一

#### 2026-01-06 - skillsの情報整理タスク完了
- task-designerで設計実施
- 結果: skillsディレクトリは存在しない
- プラグイン構成を確認: commands/task.md, agents/配下の3ファイルのみ
- タスクの前提が誤りだったため、対象なしとして完了

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

