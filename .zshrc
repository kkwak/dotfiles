#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# local folder created by poetry (python)
fpath+=~/.zfunc

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Required for EMACS multi-term as .zprofile is not loaded
if [[ -z "$LANG" ]]; then
  export LANG=en_US.UTF-8
fi

export LC_ALL=$LANG
export TERM=xterm-256color

case `uname` in
  Darwin)
    # commands for OS X go here
    # requires autojump: brew install autojump
    [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

    alias brewup='brew update && brew upgrade && brew cleanup'
    alias e='emacsclient -nw -c -a "" "$@"'

    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    export EDITOR="nvim"
    alias v='nvim'
    alias vim='nvim'
    alias ssh='TERM=xterm-256color ssh'

    # python https://github.com/Qix-/better-exceptions
    export BETTER_EXCEPTIONS=1

    export GOPATH=$HOME/projects/golang
    export PATH=$JAVA_HOME/bin:/usr/local/opt/gnu-tar/libexec/gnubin:/usr/local/bin::$PATH

    # called before every command
    precmd () {
      printf '\033]2;'$(pwd)'\033\\'
    }
    eval "$(pyenv init -)"

    # tabtab source for serverless package
    # uninstall by removing these lines or running `tabtab uninstall serverless`
    [[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
    # tabtab source for sls package
    # uninstall by removing these lines or running `tabtab uninstall sls`
    [[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

  ;;
  Linux)
    echo "Setting up for Linux"
    export EDITOR="vim"
    alias v='vim'

    export PATH="/usr/local/bin:$PATH"

  ;;
  FreeBSD)
    echo "Setting up for FreeBSD"
    export EDITOR="vim"
    alias v='vim'
    # commands for FreeBSD go here
  ;;
esac

bindkey -v

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# https://github.com/junegunn/fzf : command-line fuzzy finder
[ -f "${HOME}/.fzf.zsh" ] && source "${HOME}/.fzf.zsh"

alias ll='ls -Glah'

# git related aliases
alias s='git status'
alias l='git lg'
alias b='git branch'
alias gg='git gui'
alias gk='gitk --all'

alias up='zsh ~/.config/up.sh'

