
PS1="\[\e[1;35m\]\u@\[\e[1;34m\]\W$\[\e[m\] "

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
