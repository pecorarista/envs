function exists { which $1 &> /dev/null }

# Python
if [ ! -d $HOME/anaconda3 ]
then
    curl -fsSL https://repo.continuum.io/archive/Anaconda3-2018.12-Linux-x86_64.sh | bash -b
fi
ANACONDA_HOME=$HOME/anaconda3
source $HOME/anaconda3/etc/profile.d/conda.sh
conda activate

if ! exists powerline-daemon
then
    pip install --user powerline-status
fi

powerline-daemon -q
source "$HOME/.local/lib/$(python -V | sed -e 's/Python 3\.\([6-7]\)\.[0-9]\+/python3.\1/')/site-packages/powerline/bindings/zsh/powerline.zsh"

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

bindkey '^[[Z' reverse-menu-complete
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

function svg2pdf () {
    if ! $(which rsvg-convert &> /dev/null) && [ -f /etc/debian_version ]
    then
        echo 'The command `rsvg-convert` was not found. Install librsvg2-bin.'
    else
        rsvg-convert -f pdf -o ${1:r}.pdf $1
    fi
}

if [ -z "$SSH_AUTH_SOCK" ]
then
    eval $(ssh-agent) &> /dev/null
fi
if [ -z "$(ssh-add -l | awk -F' ' '{ print $3 }' | grep 'id_rsa')" ]
then
    ssh-add ~/.ssh/id_rsa &> /dev/null
fi

alias ls='ls --color=auto'
alias R='R --no-save'

if exists peco
then
    function peco-history-selection() {
        BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
        CURSOR=$#BUFFER
        zle -R -c
    }

    zle -N peco-history-selection
    bindkey '^R' peco-history-selection
fi

__git_files () {
    _wanted files expl 'local files' _files
}

if grep "Microsoft" /proc/version &> /dev/null
then
    [[ -z "$TMUX" && -n "$USE_TMUX" ]] && {
        [[ -n "$ATTACH_ONLY" ]] && {
            tmux a 2>/dev/null || {
                cd && exec tmux
            }
            exit
        }

        tmux new-window -c "$PWD" 2>/dev/null && exec tmux a
        exec tmux
    }

    export DISPLAY="localhost:0.0"
fi
