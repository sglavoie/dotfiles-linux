# Pretty heavily based on `Luke's config for the Zoomer Shell`
# https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[magenta]%}%36<..<%~%<<%{$fg[red]%}]%{$reset_color%}$%b "

export PATH="$HOME/dev/git-scripts:$HOME/.local/bin:$HOME/.node/bin:$PATH"

# Set default editor to use
export EDITOR='nvim'
export VISUAL='nvim'

# Set variables for Python virtual envs
export WORKON_HOME="$HOME/Programming/virtualenvs"
export PROJECT_HOME="$HOME/dev"

export BROWSER='/usr/bin/brave'

# Get colorized output for `man` pages with `bat`
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)  # Include hidden files.

# Add the Git branch name of the repo
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
# PROMPT=\$vcs_info_msg_0_'%# '
zstyle ':vcs_info:git:*' formats '%b'

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

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

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Read external environment variables
source ~/Dropbox/.custom/zsh/environ.variables

SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

bindkey '^x^x' edit-command-line  # Open default editor


##### Functions

# Select a configuration file with fzf and open it with Neovim
conf() { du -a ~/.dotfiles/* ~/.config/* | cut -f1 --complement | fzf | xargs -r nvim ;}

# Select a file from current folder and recursively with fzf and open it with Neovim
se() { du -a ./* | cut -f1 --complement | fzf | xargs -r nvim ;}

# Select a file recursively from university folder with fzf and open it with default app
sc() { du -a ~/Dropbox/university/* | cut -f1 --complement | fzf | xargs -r xdg-open ;}

renamemusic() {
for f in *.mp3 *.flac *.wav *.ogg; do
    mv "$f" `echo $f | tr -cd "a-zA-Z0-9\-_\ \." | sed s/' - '/'-'/g | sed s/' '/_/g | sed s/__/_/g | sed s/'('//g | sed s/')'//g`
done
}

# Load aliases if existent.
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

# Ignore specific files/directories in Dropbox
dropbox-ignore(){
  arg1=$1
  arg2=$2
  find . -type $arg1 -name "$arg2" |
      xargs -I {} attr -s com.dropbox.ignored -V 1 "{}"
}

# Sync specific files/directories in Dropbox
# that were previously ignored (or not)
dropbox-sync(){
  arg1=$1
  arg2=$2
  find . -type $arg1 -name "$arg2" |
      xargs -I {} attr -s com.dropbox.ignored -V 0 "{}"
}

# Load Zsh plugins
source "$HOME/.dotfiles/plugins/forgit/forgit.plugin.zsh"
source "$HOME/.dotfiles/plugins/git-prompt/git-prompt.plugin.zsh"
source "$HOME/.dotfiles/plugins/git/git.plugin.zsh"
source "$HOME/.dotfiles/plugins/gitignore/gitignore.plugin.zsh"

# Load virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh


################################################################################
# Following examples taken from:
# https://github.com/junegunn/fzf/wiki/examples

# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-80 | fzf --nth=1,2
  ) && ${EDITOR:-vim} $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}

# Search man pages with fzf
fman() {
    man -k . | fzf --prompt='Man> ' | awk '{print $1}' | xargs -r man
}
################################################################################

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
