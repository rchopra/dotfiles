# Set custom prompt
setopt PROMPT_SUBST
autoload -U promptinit
promptinit
prompt grb

# Initialize completion
autoload -U compinit
compinit

# Add paths
export PATH="/Users/rishi/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Colorize terminal
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -lahG'
export GREP_OPTIONS="--color"

# FZF Options
export FZF_DEFAULT_COMMAND='ag -g ""'

# Fix tmux bug
DISABLE_AUTO_TITLE=true

export EDITOR="nvim"
bindkey -e

#vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

setopt AUTO_CD

alias g='git '
alias gt='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gci='commit-helper'
alias gr='git r'
alias gl='git l'

alias got='git '
alias get='git '

export GIT_AUTHOR_NAME="Rishi Chopra"
export GIT_AUTHOR_EMAIL="rqchopra@gmail.com"

alias be='bundle exec'
alias tunnel_airflow='ssh -v -N -A -J giants-bastion -L 8080:localhost:8080 airflow'

plugins=(git)
ctags=/usr/local/bin/ctags

set TERM=xterm-256color

# Set GEM_HOME for Ruby gems
export GEM_HOME="$HOME/.gem"
