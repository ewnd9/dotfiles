#!/bin/bash

set -e

function link {
  SRC=$HOME/dotfiles/$1
  DEST=$HOME/$2

  ln -s $SRC $DEST
  echo "ln -s $SRC -> $DEST"
}

link config/xinitrc .xinitrc
link config/xinitrc .xsession

link config/awesome .config/awesome
link config/vim .vim
link config/zsh .zsh
link config/gtk.css .config/gtk-3.0/gtk.css

link config/zshrc .zshrc
link config/vimrc .vimrc
link config/tmux.conf .tmux.conf

mkdir -p ~/.atom
link config/atom/config.cson .atom/config.cson
link config/atom/keymaps.cson .atom/keymaps.cson

mkdir -p ~/misc
link misc.md misc/README.md

DROPBOX_LINKS="$HOME/Dropbox/links.sh"
[ -f "$DROPBOX_LINKS" ] && . "$DROPBOX_LINKS" || echo "\"$DROPBOX_LINKS\" doesn't exist"
