#!/bin/bash

set -e

if [[ $1 = "--init" ]]; then
  alacritty -e "$HOME/dotfiles/scripts/tmux/default.tmux"
else
  alacritty -e "$HOME/dotfiles/scripts/tmux/open-two-verticals.tmux"
fi
