#!/bin/bash
# var for session name (to avoid repeated occurences)
sn=dev

# Start the session and window 0 in /etc
#   This will also be the default cwd for new windows created
#   via a binding unless overridden with default-path.
tmux new-session -s "$sn" -d

# Create 3 windows
tmux new-window -t "$sn:0" -n "nvim"
tmux new-window -t "$sn:9" -n "python"
tmux new-window -t "$sn:8" -n "terminal"

# Split terminal window vertically, then split the right pane horizontally,
# then switch to the left pane
# _________________
# | >_    |>      |
# |       |       |
# | FOCUS |-------|
# | HERE  |>      |
# |       |       |
# -----------------
tmux split-window -h
#tmux split-window -v
tmux select-pane -L

# Set up Neovim ready to open files
tmux send-keys -t "$sn:0" C-z 'aneovim && nvim .' Enter

# Set up alias for IPython and clear the screen when entering IPython
tmux send-keys -t "$sn:9" C-z 'scpy' Enter
tmux send-keys -t "$sn:9" 'clear' Enter

# Select window #0 and attach to the session
tmux select-window -t "$sn:0"
tmux -2 attach-session -t "$sn"
