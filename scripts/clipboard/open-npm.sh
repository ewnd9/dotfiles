#!/bin/bash

QUERY=$(xclip -out -selection primary)

notify-send -t 1000 opening
"$HOME/.npm-packages/bin/cached-npm-repo" "$QUERY"

if [[ $? = 0 ]]
then
  echo ok
else
  notify-send -t 1000 "\"$QUERY\" is not found"
fi
