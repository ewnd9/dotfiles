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

link zshrc .zshrc
link vimrc .vimrc
link tmux.conf .tmux.conf
link atom.config.cson .atom/config.cson

sudo ln -s /home/ewnd9/dotfiles/gnome-terminal-tmux.sh /usr/bin/gnome-terminal-tmux.sh
sudo ln -s /home/ewnd9/dotfiles/lnbin.sh /usr/bin/lnbin
