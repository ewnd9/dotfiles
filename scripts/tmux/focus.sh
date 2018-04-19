#!/bin/bash

set -e

export LC_NUMERIC="en_US.UTF-8"

# https://superuser.com/a/433702
CURRENT_WINDOW=$(tmux list-window | tr '\t' ' ' | sed -n -e '/(active)/s/^[^:]*: *\([^ ]*\) .*/\1/gp')
CURRENT_PANE=$(tmux list-panes | sed -n -e '/(active)/s/^\([^:]*\):.*/\1/gp')
PANE_ID="$CURRENT_WINDOW.$CURRENT_PANE"

WINDOW_HEIGHT=$(tmux display -p '#{window_height}')
PANE_HEIGHT=$(tmux display -p '#{pane_height}')

EIGHTY_PERCENT=$(echo "scale=0; ($WINDOW_HEIGHT * 0.8) / 1" | bc)

BACKUP_FILE="/tmp/tmux-focus"

if [[ "$PANE_HEIGHT" -gt "$EIGHTY_PERCENT" ]]; then
  for var in BACKUP_PANE BACKUP_LAYOUT; do
    IFS= read -r "$var" || break
  done < $BACKUP_FILE

  if [[ "$PANE_ID" == "$BACKUP_PANE" ]]; then
    tmux select-layout "$BACKUP_LAYOUT"
  fi
else
  TMUX_LAYOUT=$(tmux display-message -p "#{window_layout}")
  printf "%s\n%s" "$PANE_ID" "$TMUX_LAYOUT" > $BACKUP_FILE
  tmux resize-pane -y 100
fi

