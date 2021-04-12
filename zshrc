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
alias vi="nvim"
bindkey -e

#vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

setopt AUTO_CD

export GIT_AUTHOR_NAME="Rishi Chopra"
export GIT_AUTHOR_EMAIL="rqchopra@gmail.com"

# Convenient aliases
alias g='git '
alias be='bundle exec'
alias tunnel_airflow='ssh -v -N -A -J giants-bastion -L 8080:localhost:8080 airflow'

plugins=(git)
ctags=/usr/local/bin/ctags

set TERM=xterm-256color

# Set GEM_HOME for Ruby gems
export GEM_HOME="$HOME/.gem"

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
