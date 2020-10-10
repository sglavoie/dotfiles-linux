# Load multiple SSH keys
zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa_datopian

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/dev/git-scripts:$HOME/.local/bin:$HOME/.node/bin:$HOME/.cargo/bin:$HOME/.gem/ruby/2.7.0/bin:$PATH"

# Source `z` to jump around
. $HOME/.z_git/z.sh

# Set default editor to use
export EDITOR='nvim'
export VISUAL='nvim'

# Hate to admit it, but I have to use it as my daily driver...
export BROWSER='/usr/bin/google-chrome-stable'

# Get colorized output for `man` pages with `bat`
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" --glob "!.venv/*" --glob "!node_modules/*"'

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

# Read external environment variables
source ~/Dropbox/.custom/zsh/environ.variables

bindkey '^x^x' edit-command-line  # Open default editor

##### Functions

# Select a configuration file with fzf and open it with Neovim
conf() { find ~/.config/* | cut -f1 --complement | fzf | xargs -r nvim ;}

# Select a file from current folder and recursively with fzf and open it with Neovim
se() { find . | cut -f1 --complement | fzf | xargs -r nvim ;}

# Select a file recursively from university folder with fzf and open it with default app
sc() { find ~/Dropbox/university/* | cut -f1 --complement | fzf | xargs -r xdg-open ;}

renamemp3() {
for f in *.mp3; do
    mv "$f" `echo $f | tr -cd "a-zA-Z0-9\-_\ \." \
        | sed s/' - '/'-'/g | sed s/' '/_/g \
        | sed s/__/_/g | sed s/'('//g | sed s/')'//g`
done
}

# Load aliases if existent.
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

# Path to your oh-my-zsh installation.
export ZSH="/home/sglavoie/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gallifrey"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ssh-agent fzf gitignore zsh-autosuggestions history-substring-search)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
