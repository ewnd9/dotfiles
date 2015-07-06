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

link config/base16-gnome-terminal .config/base16-gnome-terminal
source ~/.config/base16-gnome-terminal/base16-default.dark.sh

link zshrc .zshrc
link vimrc .vimrc
link tmux.conf .tmux.conf

