#!/bin/sh

# https://github.com/blueimp/atom-open-terminal-here
#
# Copyright 2015, Sebastian Tschan
# https://blueimp.net
#
# Licensed under the MIT license:
# http://opensource.org/licenses/MIT

# Keyboard shortcut to open a new terminal emulator tab:
KEYSTROKE='ctrl+shift+t'
# Pattern to identify a terminal emulator window by name:
WINDOW_NAME="$USER@$(hostname)"
# Terminal emulator command:
TERMINAL_EMULATOR='gnome-terminal'

# Parse command-line options:
while getopts t:w:k: opt; do
  case $opt in
    t) TERMINAL_EMULATOR="$OPTARG"
       ;;
    w) WINDOW_NAME="$OPTARG"
       ;;
    k) KEYSTROKE="$OPTARG"
       ;;
    ?) echo "Usage: $0 [-t terminal_emulator] [-w window_name] [-k keystroke]"
       exit 2
       ;;
  esac
done

$TERMINAL_EMULATOR
