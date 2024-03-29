#!/bin/sh

# git
git config --global core.editor vim
git config --global alias.tree 'log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta bold)%d%Creset %s" -n 20'

# config
mkdir ~/.config
for file in `\find ./.config/ -maxdepth 1 -type f`; do
	ln -sf ~/dotfiles/$file ~/$file
done

# beep
echo "set bell-style none" >> ~/.inputrc

# bashrc
cat .bashrc >> ~/.bashrc

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# tmux
sudo apt install tmux
cat .tmux.conf >> ~/.tmux.conf
tmux source ~/.tmux.conf

# update
sudo add-apt-repository ppa:neovim-ppa/stable
ln -sf ~/dotfiles/.update.sh ~/.update.sh
~/.update.sh

# neovim
# https://github.com/neovim/neovim
sudo apt install -y neovim
ln -sf ~/dotfiles/nvim ~/.config/nvim
# https://github.com/junegunn/vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Python
# https://github.com/pyenv/pyenv#automatic-installer
sudo apt update; sudo apt install -y make build-essential libssl-dev zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# bashrcを反映
exec $SHELL -l
