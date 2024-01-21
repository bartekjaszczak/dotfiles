# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Dotfiles alias
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Custom aliases
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias ll='ls -al'
alias df='df -h'
alias free='free -m'
alias pacman='sudo pacman'
alias ..='cd ..'
alias mkdir='mkdir -pv'

# Shell options
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend

HISTSIZE=2000
HISTFILESIZE=20000
PS1='[\u@\h \W]\$ '

set -o vi
bind "set completion-ignore-case on"

# Default editor
export VISUAL=nvim
export EDITOR=nvim

# CMake settings
export CMAKE_EXPORT_COMPILE_COMMANDS=1
export CMAKE_GENERATOR="Ninja"

# zk
export ZK_NOTEBOOK_DIR=$HOME/notes

# Archive extractor
ex ()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *.deb)       ar x $1        ;;
            *.tar.xz)    tar xf $1      ;;
            *.tar.zst)   unzstd $1      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# XDG paths
if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ] ; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_CACHE_HOME" ] ; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi

# Fzf configuration
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# Starship
eval "$(starship init bash)"
