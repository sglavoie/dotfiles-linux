# Setup fzf
# ---------
if [[ ! "$PATH" == */home/sglavoie/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/sglavoie/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/sglavoie/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/sglavoie/.fzf/shell/key-bindings.bash"
