#!/bin/sh

BUNDLE="$HOME/dotfiles/vim/.bundle/"

cd $BUNDLE/YouCompleteMe
git submodule update --init --recursive
./install.py --tern-completer

