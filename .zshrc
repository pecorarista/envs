# Set up the prompt

autoload -Uz promptinit
promptinit
case "$USER" in
    sakura)
        prompt adam1 magenta cyan
        ;;
    ubuntu)
        prompt adam1 red cyan
        ;;
    *)
        prompt adam1
        ;;
esac

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

alias vi='gvim -v'
alias vim='gvim -v'
alias l='ls --color=auto'
alias ls='ls --color=auto'
alias R='R --no-save'

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
    eval $(ssh-agent)
fi
if [ -z "$(ssh-add -l | awk -F' ' '{ print $3 }' | grep 'id_rsa')" ]
then
    ssh-add ~/.ssh/id_rsa &> /dev/null
fi

function exists { which $1 &> /dev/null }

if exists percol
then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi
