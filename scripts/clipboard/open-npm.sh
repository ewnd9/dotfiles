#!/bin/bash

QUERY=$(xclip -out -selection primary)

notify-send -t 1000 opening

if "$HOME/.npm-packages/bin/cached-npm-repo" "$QUERY"; then
  echo ok
else
  notify-send -t 1000 "\"$QUERY\" is not found"
fi
