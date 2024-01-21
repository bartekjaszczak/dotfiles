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
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=50000

export HISTORY_IGNORE="(ls|cd|pwd|exit|cd -|cd ..)"

unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/bartek/.zshrc'

autoload -Uz compinit
compinit

# Default editor
export VISUAL=nvim
export EDITOR=nvim

# CMake settings
export CMAKE_EXPORT_COMPILE_COMMANDS=1
export CMAKE_GENERATOR="Ninja"

# zk
export ZK_NOTEBOOK_DIR=$HOME/notes

function ex {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        echo "       ex <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    else
        for n in "$@"
        do
            if [ -f "$n" ] ; then
                case "${n%,}" in
                    *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                        tar xvf "$n"       ;;
                    *.lzma)      unlzma ./"$n"      ;;
                    *.bz2)       bunzip2 ./"$n"     ;;
                    *.cbr|*.rar)       unrar x -ad ./"$n" ;;
                    *.gz)        gunzip ./"$n"      ;;
                    *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
                    *.z)         uncompress ./"$n"  ;;
                    *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                        7z x ./"$n"        ;;
                    *.xz)        unxz ./"$n"        ;;
                    *.exe)       cabextract ./"$n"  ;;
                    *.cpio)      cpio -id < ./"$n"  ;;
                    *.cba|*.ace)      unace x ./"$n"      ;;
                    *)
                        echo "extract: '$n' - unknown archive method"
                        return 1
                        ;;
                esac
            else
                echo "'$n' - file does not exist"
                return 1
            fi
        done
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
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Starship
eval "$(starship init zsh)"
