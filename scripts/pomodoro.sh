#!/bin/sh

interval="1500"

if [ "$#" = "1" ]; then
  interval="$1"
fi

echo 'x = naughty.notify({ text = "stand up!", timeout = 0, run = function () naughty.destroy(x) \n awful.util.spawn_with_shell("sleep '"$interval"' && sh /home/ewnd9/dotfiles/scripts/pomodoro.sh") end })' | awesome-client
