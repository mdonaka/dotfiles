# prompt
PROMPT='%F{green}%n@%F{cyan}%1~$%f '

# completion (git補完など。zsh同梱の補完定義を有効化)
autoload -Uz compinit && compinit
# 大文字小文字を区別せず補完 / メニュー選択
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
fi

# fnm (Node.js)
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd)"
fi

# neovim
alias vim='nvim'

# fzf
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi
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
    git add $(paste -s - <<< $selected)
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
    git diff $(paste -s - <<< $selected)
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
