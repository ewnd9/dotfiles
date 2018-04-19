#!/bin/sh

DEC=$(xdotool getactivewindow)
# HEX=$(printf 0x%x $dec)
TAG=$(($1 - 1))

wmctrl -i -r "$DEC" -t "$TAG"
