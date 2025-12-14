# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Language

**Always respond in Japanese (日本語).**

## Repository Overview

This is a dotfiles repository containing shell and editor configurations for a Linux/WSL development environment.

## Setup

```bash
# Initial setup (run from ~/dotfiles after cloning)
./setup.sh

# After shell restart, install Python versions
./setup2.sh
```

## Structure

- `.bashrc` - Bash configuration with pyenv, fzf integrations, and custom git helper functions (fadd, fdiff, fcheckout, flogin)
- `.config/` - Config files for flake8 and pep8
- `nvim/` - Neovim configuration using lazy.nvim plugin manager

## Neovim Configuration

The nvim config follows a modular Lua structure:

```
nvim/
├── init.lua              # Entry point, loads config modules
├── lua/
│   ├── config/
│   │   ├── options.lua   # Editor settings
│   │   ├── keymaps.lua   # Key bindings
│   │   ├── filetypes.lua # Filetype settings
│   │   └── lazy.lua      # lazy.nvim bootstrap and setup
│   └── plugins/          # Plugin specs (one file per plugin/category)
└── coc-settings.json     # CoC LSP settings
```

**Leader key**: Space
**Plugin manager**: lazy.nvim (auto-bootstraps on first run)

Key plugins are organized by language/function: coc (LSP), fzf, git, filer, and language-specific configs (cpp, python, rust, terraform, markdown, csv, llm).
