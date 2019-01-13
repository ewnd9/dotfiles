#!/bin/sh

code "$HOME/Dropbox/plan" &
sleep 2

DEC=$(xdotool getactivewindow)
# HEX=$(printf 0x%x $dec)
TAG=5

wmctrl -i -r "$DEC" -t "$TAG"
