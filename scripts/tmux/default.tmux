#!/bin/bash
# var for session name (to avoid repeated occurences)
sn=default

tmux kill-session -t "$sn"
cd /home/ewnd9
tmux new-session -s "$sn" -n etc -d

tmux select-window -t "$sn"

tmux split-window -h

tmux send-keys 'move-to-tag 3' 'C-m'
tmux select-pane -L

tmux -2 attach-session -t "$sn"
