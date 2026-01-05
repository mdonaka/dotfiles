# Claude Plugins (mdonaka)

Claude Code用のプラグインマーケットプレイス

## セットアップ

```bash
# マーケットプレイスを追加
/plugin marketplace add ~/dotfiles/claude_plugins
```

## プラグイン一覧

| プラグイン | 説明 |
|-----------|------|
| hello | 終了時に "hello" を表示 |

## プラグインのインストール

```bash
/plugin install hello@mdonaka
```

## プラグインの作成

1. `claude_plugins/<plugin-name>/` ディレクトリを作成
2. 必要なファイルを配置:

```
<plugin-name>/
├── .claude-plugin/
│   └── plugin.json       # プラグイン定義
├── hooks/
│   └── hooks.json        # フック設定（任意）
├── scripts/
│   └── *.sh              # スクリプト（任意）
└── commands/
    └── *.md              # コマンド（任意）
```

3. `marketplace.json` にプラグインを追加:

```json
{
  "name": "<plugin-name>",
  "source": "./<plugin-name>",
  "description": "説明",
  "version": "1.0.0"
}
```

## setup.sh

各プラグインは `setup.sh` を持つことができる。

記載内容：
- プラグインのインストール (`/plugin install`)
- プラグイン固有のセットアップ処理（依存関係のインストール等）
