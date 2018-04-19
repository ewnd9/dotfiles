#!/bin/bash

FILE="/sys/class/leds/asus::kbd_backlight/brightness"
VALUE=$(cat $FILE)

if [[ "$1" == "up" ]]; then
  VALUE=$((VALUE + 1 > 2 ? 2 : VALUE + 1))
else
  VALUE=$((VALUE - 1 < 0 ? 0 : VALUE - 1))
fi

echo $VALUE | tee /sys/class/leds/asus::kbd_backlight/brightness
