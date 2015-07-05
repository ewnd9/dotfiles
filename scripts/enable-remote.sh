#!/bin/bash

#!/bin/bash
 
# xrandr --newmode "1920x1200"  193.25  1920 2056 2256 2592  1200 1203 1209 1245 -hsync +vsync
# xrandr --addmode VIRTUAL1 1920x1200
# "1920x1100"  176.25  1920 2048 2248 2576  1100 1103 1113 1141 -hsync +vsync
 
xrandr --newmode "1920x1000" 159.25  1920 2040 2240 2560  1000 1003 1013 1038 -hsync +vsync
xrandr --addmode VIRTUAL1 1920x1000
xrandr --output VIRTUAL1 --mode 1920x1000 --left-of eDP1
xrandr
 
x11vnc -clip 1920x1000+0+0 -scale 128/192 -nocursorshape
#-ncache
 
# Turn off output when x11vnc session ends
xrandr --output VIRTUAL1 --off
