#!/bin/sh

dec=$(xdotool getactivewindow)
hex=$(printf 0x%x $dec)
tag=$(($1 - 1))

wmctrl -i -r $dec -t $tag
