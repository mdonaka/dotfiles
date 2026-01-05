#!/bin/bash
#
# claude_plugins/setup.sh
# Claude Codeプラグインのセットアップ手順を表示
#
# 注意: /plugin コマンドはClaude Code内でのみ実行可能です。
#       このスクリプトはセットアップ手順を案内します。
#

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Claude Plugins Setup Guide ==="
echo ""
echo "以下のコマンドをClaude Code内で実行してください："
echo ""
echo "----------------------------------------"
echo "1. マーケットプレイスを追加:"
echo ""
echo "   /plugin marketplace add $SCRIPT_DIR"
echo ""
echo "----------------------------------------"

# プラグインディレクトリを探索
plugin_count=0
for plugin_dir in "$SCRIPT_DIR"/*/; do
    plugin_name="$(basename "$plugin_dir")"

    # 隠しディレクトリはスキップ
    if [[ "$plugin_name" == .* ]]; then
        continue
    fi

    # plugin.jsonが存在するか確認
    if [[ -f "$plugin_dir/.claude-plugin/plugin.json" ]]; then
        if [[ $plugin_count -eq 0 ]]; then
            echo "2. プラグインをインストール:"
            echo ""
        fi
        plugin_count=$((plugin_count + 1))
        echo "   /plugin install ${plugin_name}@mdonaka"
    fi
done

if [[ $plugin_count -gt 0 ]]; then
    echo ""
    echo "----------------------------------------"
fi

echo ""
echo "=== セットアップ完了後 ==="
echo ""
echo "インストール済みプラグインの確認:"
echo "   /plugin list"
echo ""
