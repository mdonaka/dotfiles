#!/bin/zsh

# Homebrew
if ! command -v brew &> /dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# brewのPATHを永続化(Apple Silicon)
if ! grep -q 'brew shellenv' ~/.zprofile 2>/dev/null; then
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# git
git config --global core.editor vim

# Claude Code
mkdir -p ~/.claude
ln -sf ~/dotfiles/CLAUDE.md ~/.claude/CLAUDE.md
git config --global alias.tree 'log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta bold)%d%Creset %s" -n 20'

# zsh
if ! grep -q 'dotfiles/.zshrc' ~/.zshrc 2>/dev/null; then
	echo 'source ~/dotfiles/.zshrc' >> ~/.zshrc
fi

# config
mkdir -p ~/.config
for file in $(find ./.config/ -maxdepth 1 -type f); do
	ln -sf ~/dotfiles/$file ~/$file
done

# fzf
brew install fzf
# キーバインド/補完は.zshrcの`source <(fzf --zsh)`で有効化

# neovim (プラグインはlazy.nvimが起動時に自動bootstrap)
brew install neovim
ln -sf ~/dotfiles/nvim ~/.config/nvim

# Python (pyenv)
brew install pyenv

# fnm (Node.js)
brew install fnm

