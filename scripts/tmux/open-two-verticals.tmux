#!/bin/bash

tmux new-session -n linux -d

tmux split-window -h
tmux select-pane -L

#TERM=screen-256color tmux -2 attach-session
tmux -2 attach-session
