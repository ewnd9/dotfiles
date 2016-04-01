#!/bin/bash

function link {
	SRC=/home/ewnd9/dotfiles/$1
	DEST=/home/ewnd9/$2

	ln -s $SRC $DEST
	echo "ln -s $SRC -> $DEST"
}

link xinitrc .xinitrc
link xinitrc .xsession

link config/awesome .config/awesome
link config/vim .vim
link config/zsh .zsh
link config/gtk.css .config/gtk-3.0/gtk.css

link zshrc .zshrc
link vimrc .vimrc
link tmux.conf .tmux.conf
link xmodmap .xmodmap

mkdir -p ~/.atom
link config/atom/config.cson .atom/config.cson
mkdir -p ~/.atom/packages/modular-snippets
link config/atom/snippets .atom/packages/modular-snippets/snippets

mkdir -p ~/.config/manuelschneid3r
link config/albert/albert.conf .config/manuelschneid3r/albert.conf

mkdir -p ~/misc
link misc.md misc/README.md

sudo ln -s /home/ewnd9/dotfiles/scripts/gnome-terminal-tmux.sh /usr/bin/gnome-terminal-tmux.sh
sudo ln -s /home/ewnd9/dotfiles/scripts/lnbin.sh /usr/bin/lnbin
sudo ln -s /home/ewnd9/dotfiles/scripts/kbd.sh /usr/bin/kbd
sudo ln -s /home/ewnd9/dotfiles/scripts/np /usr/bin/np
sudo ln -s /home/ewnd9/dotfiles/scripts/put-md-to-folder.js /usr/bin/put-md-to-folder
sudo ln -s /home/ewnd9/dotfiles/scripts/add-prefixes-in-folder.js /usr/bin/add-prefixes-in-folder

sudo ln -s /home/ewnd9/dotfiles/scripts/wm/move-to-tag.sh /usr/bin/move-to-tag
sudo ln -s /home/ewnd9/dotfiles/scripts/wm/open-tag.sh /usr/bin/open-tag
sudo ln -s /home/ewnd9/dotfiles/scripts/wm/switch-to-tag.sh /usr/bin/switch-to-tag
sudo ln -s /home/ewnd9/dotfiles/scripts/pomodoro.sh /usr/bin/po
sudo ln -s /home/ewnd9/dotfiles/scripts/canonical-path.sh /usr/bin/canonical-path

sudo ln -s /home/ewnd9/dotfiles/scripts/atom-open-in-terminal.sh /usr/local/bin/terminal-tab.sh

sudo mv /usr/bin/link /usr/bin/link-old
sudo ln -s /home/ewnd9/dotfiles/scripts/link.sh /usr/bin/link

sudo mv /usr/bin/xdg-open /usr/bin/xdg-open-old
sudo ln -s /home/ewnd9/dotfiles/scripts/xdg-open /usr/bin/xdg-open
sudo ln -s $HOME/dotfiles/env.desktop /usr/share/xsessions/env.desktop
