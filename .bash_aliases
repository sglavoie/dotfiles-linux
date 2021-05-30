# Shortcuts
alias allextensions="find . -type f -name '*.*' | sed 's|.*\.||' | sort -u"
alias articlesbycategories="pushd > /dev/null; \
    cd ~/dev/sglavoie/sglavoie.github.io-source/content; \
    find . -type f -name '*.md' ! -wholename '*/pages*' | cut -d/ -f2 \
    | sort | uniq -c | sort -n; popd > /dev/null"
alias articlesnum="pushd > /dev/null; \
    cd ~/dev/sglavoie/sglavoie.github.io-source/content; \
    find . -name '*.md' | cut -d '/' -f3 | grep -P '^\d.*' \
    | sort | tail -1; popd > /dev/null"
alias c='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias cat="bat"
alias cl='clear'
alias diff='diff-so-fancy'
alias dockerclean='sudo systemctl start docker.service; docker rmi -f $(docker images -a -q); docker volume rm -f $(docker volume ls -q); docker rm -f $(docker ps -a -q); docker network prune'
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
alias sgl='cd ~/dev/sglavoie/sglavoie.github.io-source && . ~/Programming/virtualenvs/sg/bin/activate && n content/pages/learning-progress-2021.md'
alias shutdown='sudo shutdown'
alias sysupdate='sudo apt update && sudo apt dist-upgrade -y && sudo snap refresh && sudo apt autoremove -y && sudo apt clean'
alias t='tmux'
alias treeold='tree -hDF | less'
alias www='python -m http.server'

# Know when a long-running command is done by appending "; alert" at the end
alias alert='notify-send "Command done..." && aplay ~/Music/bell.wav 1&> /dev/null'

# Do not delete / or prompt if deleting more than 3 files at a time
alias rm='rm -I --preserve-root'

# confirmation
alias ln='ln -i'
alias cp='cp -iv'
alias mv='mv -iv'

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
alias cdasp='cd ~/Dropbox/university/modules/level5/agile_software_projects/project'
alias cdgp='cd ~/Dropbox/university/modules/level5/graphics_programming/graded_assignments'
alias cdnotes='cd ~/Dropbox/notes'
alias cdpwd='cd ~/Dropbox/university/modules/level5/programming_with_data/midterm/project'

# GitHub paths
alias cdbettervim='cd ~/dev/sglavoie/better-vim-experience'
alias cdgit='cd ~/dev'
alias cdgrades='cd ~/dev/sglavoie/grades_calculator'
alias cdrepl='cd ~/dev/sglavoie/world-class/REPL'
alias cdsg='cd ~/dev/sglavoie/sglavoie.github.io-source'
alias cdsnippets='cd ~/dev/sglavoie/code-snippets'
alias cdhelpers='cd ~/dev/sglavoie/dev-helpers'

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
alias b='python3 ~/dev/sglavoie/dev-helpers/rsync_backup/rsync_backup.py'
alias cleanhistory='python \
    ~/dev/sglavoie/dev-helpers/zsh_history_cleaner/zsh_history_cleaner.py'
alias cpsglavoie='cp -rf \
    ~/dev/sglavoie/sglavoie.github.io-source/output/* \
    ~/dev/sglavoie/sglavoie.github.io/ && \
    cd ~/dev/sglavoie/sglavoie.github.io && git add .'
alias da='deactivate'
alias jl='jupyter-lab &'
alias pipupgrade="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias pipupdateall="pip install -U \$(pip freeze | awk '{split(\$0, a, \"==\"); print a[1]}')"
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
