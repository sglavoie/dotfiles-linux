# Load multiple SSH keys
zstyle :omz:plugins:ssh-agent identities id_rsa

# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/dev/git-scripts:$HOME/.local/bin:$HOME/.node/bin:$HOME/.cargo/bin:$HOME/.gem/ruby/2.7.0/bin:$PATH"

# Source `z` to jump around
. $HOME/.z_git/z.sh

# Set default editor to use
export EDITOR='nvim'
export VISUAL='nvim'

export BROWSER='/usr/bin/google-chrome-stable'

# Get colorized output for `man` pages with `bat`
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc.
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

aptsources-cleanup () {
    sudo ~/.local/bin/aptsources-cleanup
}

# Read external environment variables
source ~/Dropbox/.custom/zsh/environ.variables

bindkey '^x^x' edit-command-line  # Open default editor

##### Functions

# Select a configuration file with fzf and open it with Neovim
conf() { find ~/.config/ ~/Dropbox/.custom/ | cut -f1 --complement | fzf | xargs -r nvim ;}

# Select a file from current folder and recursively with fzf and open it with Neovim, ignoring hidden files
se() { find -not -path '*/\.*' -type f | cut -f1 --complement | fzf | xargs -r nvim ;}

# [University specific] Select a file recursively with fzf and open it with default app in the background
sc() { find ~/Dropbox/university/ ~/dev/sglavoie/world-class/ | cut -f1 --complement | fzf | (xargs -r xdg-open &) ;}

renamemp3() {
for f in *.mp3; do
    mv "$f" `echo $f | tr -cd "a-zA-Z0-9\-_\ \." \
        | sed s/' - '/'-'/g | sed s/' '/_/g \
        | sed s/__/_/g | sed s/'('//g | sed s/')'//g`
done
}

# Source: https://www.stefaanlippens.net/pretty-csv.html
function pretty_csv {
    column -t -s, -n "$@" | less -F -S -X -K
}

# Load aliases if existent.
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

# Path to your oh-my-zsh installation.
export ZSH="/home/sglavoie/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ssh-agent fzf gitignore zsh-autosuggestions zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Activate correct virtual environment from inside Neovim when
# the VIRTUAL_ENV var is set
# From https://vi.stackexchange.com/a/7654
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sglavoie/Programming/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sglavoie/Programming/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/sglavoie/Programming/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sglavoie/Programming/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
