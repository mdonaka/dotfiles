#!/bin/sh

# vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim
git config --global core.editor vim
git config --global alias.tree 'log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta bold)%d%Creset %s" -n 20'

# config
for file in `\find ./.config/ -maxdepth 1 -type f`; do
	ln -sf ~/dotfiles/$file ~/$file
done

# update
ln -sf ~/dotfiles/.update.sh ~/.update.sh
