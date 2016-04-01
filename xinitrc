#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

wmname LG3D &
unity-settings-daemon &
google-chrome &

guake --exec='/home/ewnd9/dotfiles/scripts/twitter.tmux' &
nm-applet &
indicator-cpufreq &
prime-indicator &

dropbox start &

record-desktop &

gnome-terminal -e '/home/ewnd9/dotfiles/scripts/tmux/weechat.tmux' &
albert &

(sleep 5 && setxkbmap -layout 'us,ru' -option '' -option 'grp:alt_shift_toggle' -option 'caps:escape') &

# invoke global X session script
awesome
