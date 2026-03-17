#!/bin/zsh

# Homebrew
if ! command -v brew &> /dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# git
git config --global core.editor vim

# Claude Code
mkdir -p ~/.claude
ln -sf ~/dotfiles/CLAUDE.md ~/.claude/CLAUDE.md
git config --global alias.tree 'log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta bold)%d%Creset %s" -n 20'

# config
mkdir -p ~/.config
for file in $(find ./.config/ -maxdepth 1 -type f); do
	ln -sf ~/dotfiles/$file ~/$file
done

# fzf
brew install fzf

# neovim
brew install neovim
ln -sf ~/dotfiles/nvim ~/.config/nvim
# vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Python (pyenv)
brew install pyenv

# fnm (Node.js)
brew install fnm

