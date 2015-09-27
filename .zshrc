#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
alias ll='ls -lah'
alias 3rdup='zsh ~/.config/update-submodules.sh'
alias up='zsh ~/.config/up.sh'
alias brewup='brew upgrade && brew update && brew cleanup && brew cask cleanup'
alias e='emacsclient -t'
alias s='git st'
alias l='git lg'
alias b='git br'
alias gg='git gui'

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Required for EMACS multi-term as .zprofile is not loaded
if [[ -z "$LANG" ]]; then
  export LANG=en_US.UTF-8
fi

export LC_ALL=$LANG
export TERM=xterm-256color

