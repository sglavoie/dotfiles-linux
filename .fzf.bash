# Setup fzf
# ---------
if [[ ! "$PATH" == */home/sebastien/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/sebastien/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/sebastien/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/sebastien/.fzf/shell/key-bindings.bash"
