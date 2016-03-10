#!/bin/bash

function link {
	SRC=/home/ewnd9/dotfiles/$1
	DEST=/home/ewnd9/$2

	ln -s $SRC $DEST
	echo "ln -s $SRC -> $DEST"
}

#link terminator .config/terminator

link config/awesome .config/awesome
link config/vim .vim
link config/gtk.css .config/gtk-3.0/gtk.css

link zshrc .zshrc
link vimrc .vimrc
link tmux.conf .tmux.conf
link xmodmap .xmodmap

mkdir -p ~/.atom
link atom.config.cson .atom/config.cson
link snippets.cson .atom/snippets.cson

mkdir -p ~/soft
link soft.md soft/README.md

sudo ln -s /home/ewnd9/dotfiles/scripts/gnome-terminal-tmux.sh /usr/bin/gnome-terminal-tmux.sh
sudo ln -s /home/ewnd9/dotfiles/scripts/lnbin.sh /usr/bin/lnbin
sudo ln -s /home/ewnd9/dotfiles/scripts/kbd /usr/bin/kbd
sudo ln -s /home/ewnd9/dotfiles/scripts/np /usr/bin/np

sudo ln -s /home/ewnd9/dotfiles/scripts/wm/move-to-tag.sh /usr/bin/move-to-tag
sudo ln -s /home/ewnd9/dotfiles/scripts/wm/open-tag.sh /usr/bin/open-tag
sudo ln -s /home/ewnd9/dotfiles/scripts/wm/switch-to-tag.sh /usr/bin/switch-to-tag
sudo ln -s /home/ewnd9/dotfiles/scripts/pomodoro.sh /usr/bin/po
