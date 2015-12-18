#!/bin/bash

# xrectsel from https://github.com/lolilolicon/xrectsel
ARGUMENTS=$(xrectsel "--x=%x --y=%y --width=%w --height=%h") || exit -1

sleep 1
notify-send "start-recording"

FILE="out.gif"
rm $FILE
byzanz-record -e "nohup dummy.sh >/dev/null 2>&1" ${ARGUMENTS} $FILE
