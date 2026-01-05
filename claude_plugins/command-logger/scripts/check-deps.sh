#!/bin/bash

# command-logger プラグインの依存関係チェック
# SessionStart フックで実行される

missing=()

if ! command -v jq &> /dev/null; then
    missing+=("jq")
fi

if [ ${#missing[@]} -gt 0 ]; then
    printf "\n[command-logger] Required commands not found: %s\n" "${missing[*]}"
    printf "[command-logger] Run: brew install %s\n" "${missing[*]}"
    exit 2
fi

exit 0
