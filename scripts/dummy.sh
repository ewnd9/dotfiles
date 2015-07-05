#!/bin/bash

if [[ $1 == '-k' ]];
then
	notify-send "ending"
	sleep 1
	notify-send "ended"
	pkill -9 -f "dummy.sh"
else
    while true; do
        sleep 1000
	done
fi

