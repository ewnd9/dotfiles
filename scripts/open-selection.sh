#!/bin/sh

QUERY=$(xsel -o)

notify-send -t 1000 opening
$HOME/.npm-packages/bin/cached-npm-repo "$QUERY"

[ $? = 0 ] && echo ok || notify-send -t 1000 "\"$QUERY\" is not found"
