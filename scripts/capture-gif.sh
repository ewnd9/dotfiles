#!/bin/bash

XWININFO=$(xwininfo )
MARGIN=5

echo $XWININFO

read X < <(awk -F: '/Absolute upper-left X/{print $2}' <<< "$XWININFO")
read Y < <(awk -F: '/Absolute upper-left Y/{print $2}' <<< "$XWININFO")
read WIDTH < <(awk -F: '/Width/{print $2}' <<< "$XWININFO")
read HEIGHT < <(awk -F: '/Height/{print $2}' <<< "$XWININFO")

X=$(($X - $MARGIN))
Y=$(($Y - $MARGIN))
WIDTH=$(($WIDTH + $MARGIN * 2))
HEIGHT=$(($HEIGHT + $MARGIN * 2))

echo $X
echo $Y
echo $WIDTH
echo $HEIGHT

sleep 1
notify-send "start-recording"

FILE="out.gif"
rm $FILE
byzanz-record -e "nohup dummy.sh >/dev/null 2>&1" --x=$X --y=$Y --width=$WIDTH --height=$HEIGHT $FILE
# byzanz-record -e "nohup dummy.sh >/dev/null 2>&1" $FILE
