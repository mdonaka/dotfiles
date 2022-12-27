
# terminal
PS1="\[\e[1;32m\]\u@\[\e[1;36m\]\W$\[\e[m\] "

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# vim to nvim
alias vim=`which nvim`

export FZF_TMUX=1
export FZF_TMUX_OPTS="-p 80%"

# fuzzy add
fadd() {
  local selected
  selected=$(git status -s |
             fzf-tmux -m --ansi --preview="echo {} | \
                                           awk '{print \$2}' | \
                                           xargs git diff --color" |
             awk '{print $2}')
  if [[ -n "$selected" ]]; then
    git add `paste -s - <<< $selected`
  fi
}

# fuzzy diff
fdiff() {
  local selected
  selected=$(git status -s |
             fzf-tmux -m --ansi --preview="echo {} | \
                                           awk '{print \$2}' | \
                                           xargs git diff --color" |
             awk '{print $2}')
  if [[ -n "$selected" ]]; then
    git diff `paste -s - <<< $selected`
  fi
}

# fuzzy checkout
fcheckout() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) \
                    +m \
                    --preview="echo {} | \
                               tr -d ' *' |
                               xargs git log --color --graph --oneline")
  if [[ -n "$branch" ]]; then
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  fi
}

# fuzzy docker login
flogin() {
  local cid
  cid=$(docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}" |
        sed 1d |
        fzf-tmux --multi -q "$1" |
        awk '{print $1}')
  [ -n "$cid" ] && docker exec -it "$cid" /bin/bash
}

# tmuxがインストールされていれば実行
if which tmux >/dev/null 2>&1; then
  test -z "$TMUX" && tmux new-session && exit
else
  echo "\e[33m[Warning]\e[m Please install tmux!"
fi
