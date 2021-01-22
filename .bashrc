
# terminal
PS1="\[\e[1;32m\]\u@\[\e[1;36m\]\W$\[\e[m\] "

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# vim to nvim
alias vim=`which nvim`
