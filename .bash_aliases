# Shortcuts
alias allextensions="find . -type f -name '*.*' | sed 's|.*\.||' | sort -u"
alias articlesbycategories="pushd > /dev/null; \
    cd ~/dev/sglavoie/sglavoie.github.io-source/content; \
    find . -type f -name '*.md' ! -wholename '*/pages*' | cut -d/ -f2 \
    | sort | uniq -c | sort -n; popd > /dev/null"
alias c='code -n'
alias cat="bat"
alias cl='clear'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias diff='diff-so-fancy'
alias f='fg'
alias findinfiles="ag --nobreak --noheading . | fzf | \
    perl -pe 's|(.*?):(.*):.*|+\2 \1|' | xargs -r nvim"
alias g='git'
alias gal='git addlearning'
alias gitaliases='git config -l | grep alias | sed "s/^alias\.//g"'
alias gsda="find ~/dev/datopian -maxdepth 2 -mindepth 1 \
    -type d -exec sh -c '(echo {} && cd {} && git status -s && echo)' \;"
alias gssg="find ~/dev/sglavoie -maxdepth 1 -mindepth 1 \
    -type d -exec sh -c '(echo {} && cd {} && git status -s && echo)' \;"
alias h='history'
alias ipe='curl ipinfo.io/ip' # print external IP address
alias j='jobs -l'
alias ka='killall'
alias lastinstalls='grep installed /var/log/pacman.log | tail -n30'
alias n='nvim'
alias o='xdg-open'
alias p='python3'
alias q='exit'
alias re='tput reset'
alias reboot='sudo reboot'
alias sgl='cd ~/dev/sglavoie/sglavoie.github.io-source && . ~/Programming/virtualenvs/sg/bin/activate && n content/pages/learning-progress-2020.md'
alias shutdown='sudo shutdown'
alias t='tmux'
alias treeold='tree -hDF | less'
alias www='python -m http.server'

# Do not delete / or prompt if deleting more than 3 files at a time
alias rm='rm -I --preserve-root'

# confirmation
alias ln='ln -i'

# ls aliases
alias ea='exa -la' # Show hidden files
alias el='exa -l'  # Use a long listing format
alias e='exa --color=auto'  # Use a long listing format

# Programs
alias cast='ffmpeg -y -f x11grab -s 1366x768 -i :0.0 -f \
    alsa -i default -c:v libx264 -r 30 -c:a flac output.mkv'
alias convertcast='ffmpeg -i output.mkv -strict -2 -c copy output.mp4'
alias v='vim'

# General paths
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias cdcustom='cd ~/Dropbox/.custom'
alias cddmenu='cd ~/Dropbox/.custom/dmenu'
alias cdzsh='cd ~/Dropbox/.custom/zsh'
alias cheat='cd ~/Dropbox/Programming/cheatsheets'

# Work paths
alias cddatopian='cd ~/Dropbox/career/datopian'

# Colorize the grep command output for ease of use (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Education paths
alias cdalgo1='cd ~/Dropbox/university/modules/level4/algorithms_and_data_structures_i'
alias cdalgo='cd ~/Dropbox/university/modules/level5/algorithms_and_data_structures_ii'
alias cdfcs='cd ~/Dropbox/university/modules/level4/fundamentals_of_computer_science'
alias cdmath='cd ~/Dropbox/university/modules/level4/discrete_mathematics'
alias cdnotes='cd ~/Dropbox/notes'
alias cdnummath='cd ~/Dropbox/university/modules/level4/mathematics_for_CS'
alias cdoop='cd ~/Dropbox/university/modules/level5/object_oriented_programming/end-term/OtoDecks'
alias cdprog1='cd ~/Dropbox/university/modules/level4/introduction_to_programming_i'
alias cdprog='cd ~/Dropbox/university/modules/level4/introduction_to_programming_ii/mid-term'
alias cdweb='cd ~/Dropbox/university/modules/level4/web_development'

# GitHub paths
alias cdbettervim='cd ~/dev/sglavoie/better-vim-experience'
alias cdgit='cd ~/dev'
alias cdrepl='cd ~/dev/sglavoie/world-class/REPL'
alias cdsg='cd ~/dev/sglavoie/sglavoie.github.io-source'
alias cdsnippets='cd ~/dev/sglavoie/code-snippets'
alias cdutilities='cd ~/dev/sglavoie/python-utilities'

# Code challenges paths
alias cdchallenges='cd ~/dev/sglavoie/programming-challenges'
alias cdcodeabbey='cd ~/dev/sglavoie/programming-challenges/code_abbey'
alias cdcodewars='cd ~/dev/sglavoie/programming-challenges/codewars'
alias cdeuler='cd ~/dev/sglavoie/programming-challenges/euler'
alias cdhackerrank='cd ~/dev/sglavoie/programming-challenges/hackerrank'

# Python related
alias alearning='source ~/Programming/virtualenvs/learning/bin/activate'
alias ap='source .venv/bin/activate'
alias avenv='source venv/bin/activate'
alias arepl='source ~/Programming/virtualenvs/repl/bin/activate'
alias b='python3 ~/Programming/scripts/rsync_backup.py'
alias cleanhistory='python \
    ~/dev/sglavoie/python-utilities/zsh_history_cleaner/zsh_history_cleaner.py'
alias cpsglavoie='cp -rf \
    ~/dev/sglavoie/sglavoie.github.io-source/output/* \
    ~/dev/sglavoie/sglavoie.github.io/ && \
    cd ~/dev/sglavoie/sglavoie.github.io && git add .'
alias da='deactivate'
alias jl='jupyter-lab &'
alias pipupgrade="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias pylint='/usr/bin/env python =pylint'
alias pythonlines='find . -name \*.py | xargs wc -l'
alias pyclean='find . -regex ".*\(__pycache__\|\.py[co]\)" -delete'

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
