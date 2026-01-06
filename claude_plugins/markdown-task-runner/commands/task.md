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

### タスクの書き方

タスクは**何を**（What）を明確に記載する:

```markdown
[] ユーザー認証機能を追加する
[] APIレスポンスをキャッシュしてパフォーマンスを改善する
[] エラーハンドリングを統一して保守性を向上させる
```

**悪い例:**
```markdown
[] 認証機能
[] キャッシュ
[] エラー処理
```

タスク名自体が目的を含むよう記載する．

## アーキテクチャ

**重要**: Claude Codeではサブエージェントからサブエージェントを呼び出せないため，メインセッション（このコマンド）が直接オーケストレーションを行う．

```
メインセッション (/task)
    ├── task-designer (設計フェーズ) [固定]
    ├── {selected_agent} (実装フェーズ) [動的選択]
    │   ├── task-implementer (デフォルト)
    │   └── 専門エージェント (タスク内容に応じて選択)
    └── task-reviewer (レビューフェーズ) [固定]
```

実装フェーズでは、タスク内容に応じて最適なエージェントを動的に選択する（詳細は3.2.1参照）。

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

**タスク実行フロー:**
```
設計(1回) → [実装 → レビュー → (差し戻し?) → 実装 → レビュー...] → 承認 → 完了・コミット → 次のタスク
```

各タスクは以下のフェーズで構成される:

#### 3.1 設計フェーズ（必須・タスク開始時に1回のみ）

新しいタスクに取り掛かる際，まずTaskツールで `markdown-task-runner:task-designer` サブエージェントを起動:

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

**注意**: 設計フェーズは各タスクにつき1回のみ実行する．実装後の修正では設計フェーズに戻らない．

#### 3.1.1 タスクファイル更新（設計完了後）

設計フェーズ完了後，task-designerの出力からサブタスクを抽出してタスクファイルを更新する:

1. **サブタスク抽出**: task-designerの出力から```task```ブロックを抽出
   ```markdown
   ```task
   [] サブタスク1
   [] サブタスク2
   ```
   ```

2. **親タスク特定**: 現在進行中（`[-]`）の親タスクを特定

3. **サブタスク挿入ルール**:
   - ```task```ブロック内のタスクの**相対的なインデント構造を保持**
   - 最上位のタスク（```task```内でインデントなしのタスク）を親タスクより2スペース深く配置
   - 子孫タスクは相対的なインデントを維持（```task```内で2スペース深ければ、挿入後も+2スペース深い）
   - 既にサブタスクがある場合は，既存のサブタスクの後に追加
   - 設計タスク（名前が正確に「設計」のサブタスク）を完了（`[x]`）としてマーク

4. **既存サブタスクとの統合ルール**:
   - 重複チェック: 同名のサブタスクが既に存在する場合はスキップ
   - 挿入位置: 既存の未完了サブタスクの後に追加

5. **ファイル更新**: Editツールを使用してタスクファイルを更新

**例:**

設計前:
```markdown
[-] 認証機能を追加する
  [] 設計
```

設計後:
```markdown
[-] 認証機能を追加する
  [x] 設計
  [] ユーザーモデルを作成する
  [] 認証APIを実装する
  [] テストを追加する
```

#### 3.2 実装・レビューループ（承認されるまで繰り返し）

設計フェーズ完了後，承認が得られるまで以下のループを実行:

##### 3.2.1 エージェント選択（実装フェーズ開始前）

実装フェーズでは、タスク内容に最適なエージェントを動的に選択する。

**選択ルール:**
- 設計フェーズ・レビューフェーズは固定エージェント（task-designer, task-reviewer）
- 実装フェーズのみ動的選択を行う

**エージェント探索手順:**

1. `agents/`ディレクトリ内のエージェントを探索（Globで`agents/*.md`を取得）
2. ファイルパスからエージェント名を抽出（例: `agents/docker.md` → `docker`）
3. `task-`で始まるエージェント（task-designer, task-implementer, task-reviewer）を除外
4. 残りのエージェントのfrontmatterから`description`を取得

**マッチング基準:**

以下の優先順位でエージェントを選択:

1. **エージェント名マッチ**: エージェント名がタスク内容に部分一致する場合
   - 例: タスク「Dockerfileを作成する」→ エージェント`docker`がマッチ
   - 注: 部分一致のため「undockering」等にも`docker`がマッチする可能性があるが、許容する

2. **descriptionキーワードマッチ**: descriptionを単語に分解し、タスク内容と部分一致
   - キーワード抽出: descriptionを空白で分割し、3文字以上の単語をキーワードとする
   - 例: description「Docker環境の構築を担当」→ キーワード`["Docker環境の構築を担当"]`から「Docker」「構築」等
   - タスク「コンテナ化する」が「Docker」を含む場合マッチ

3. **デフォルトフォールバック**: マッチするエージェントがない場合は`task-implementer`を使用

**選択ロジックの実装:**

```
# 1. 専門エージェントの探索
agent_files = Glob("agents/*.md")
specialized_agents = []

for agent_file in agent_files:
    # ファイルパスからエージェント名を抽出（拡張子なし）
    # 例: "agents/docker.md" → "docker"
    agent_name = extract_filename_without_ext(agent_file)
    if agent_name.startswith("task-"):
        continue
    specialized_agents.append({
        "name": agent_name,
        "file": agent_file
    })

# 2. 各エージェントのdescriptionを取得してマッチング判定
selected_agent = None
task_content_lower = task_content.lower()

for agent in specialized_agents:
    frontmatter = parse_frontmatter(agent["file"])
    description = frontmatter.get("description", "")

    # 3a. エージェント名マッチ（部分一致）
    if agent["name"].lower() in task_content_lower:
        selected_agent = agent["name"]
        # ログ出力: 選択理由を記録
        log(f"エージェント選択: {agent['name']} (名前マッチ)")
        break

    # 3b. descriptionキーワードマッチ
    # descriptionを単語に分解（空白区切り、3文字以上）
    description_keywords = [
        word for word in description.split()
        if len(word) >= 3
    ]
    if any(keyword.lower() in task_content_lower for keyword in description_keywords):
        selected_agent = agent["name"]
        # ログ出力: 選択理由を記録
        log(f"エージェント選択: {agent['name']} (descriptionマッチ)")
        break

# 4. フォールバック
if not selected_agent:
    selected_agent = "task-implementer"
    log("エージェント選択: task-implementer (デフォルト)")
```

**選択結果の利用:**

選択されたエージェントを`3.2.2 実装フェーズ`のTaskツール呼び出しで使用する:
- 専門エージェントが選択された場合: `markdown-task-runner:{selected_agent}`
- デフォルトの場合: `markdown-task-runner:task-implementer`

##### 3.2.2 実装フェーズ

Taskツールで選択されたエージェント（デフォルト: `markdown-task-runner:task-implementer`）を起動:

```
以下のタスクを実装してください．

【タスク】
{タスク内容}

【コンテキスト】
- 作業ディレクトリ: {path}
- 設計方針: {design-output}

【期待される成果】
- {deliverables}

【注意事項】
- コードを書く際はTDDを意識
- 完了したら成果物の概要を報告
- コミットはこのフェーズでは作成しない（レビュー承認後に作成）
```

##### 3.2.3 レビューフェーズ

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

##### 3.2.4 ループ判定

- **承認された場合**: ループを抜けて3.3（完了処理）へ
- **差し戻しの場合**: 3.2.2（実装フェーズ）に戻る

#### 3.3 完了処理（レビュー承認後）

レビューで承認されたら:

1. **コミット作成**: 変更内容を1つのコミットにまとめる（タスク単位での論理的な変更として）
2. **タスクステータス更新**: タスクを完了（`[x]`）にマーク
3. **作業ログ記録**: 完了時刻と成果物を記録
4. **次のタスクへ**: 次の未完了タスクがあれば3.1（設計フェーズ）に戻る

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
- 設計: `markdown-task-runner:task-designer`（固定）
- 実装: `markdown-task-runner:{selected_agent}`（動的選択、デフォルトは`task-implementer`）
- レビュー: `markdown-task-runner:task-reviewer`（固定）

実装フェーズでは、セクション3.2.1のエージェント選択ロジックに従って適切なエージェントを選択する。
