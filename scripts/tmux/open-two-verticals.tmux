#!/bin/bash

tmux new-session -n yo -d

tmux split-window -h
tmux select-pane -L

tmux -2 attach-session
