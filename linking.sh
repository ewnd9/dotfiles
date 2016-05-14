#!/bin/bash

set -e

function link {
	SRC=$HOME/dotfiles/$1
	DEST=$HOME/$2

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

mkdir -p ~/misc
link misc.md misc/README.md

sudo ln -s $HOME/dotfiles/scripts/gnome-terminal-tmux.sh /usr/bin/gnome-terminal-tmux.sh
sudo ln -s $HOME/dotfiles/scripts/lnbin.sh /usr/bin/lnbin
sudo ln -s $HOME/dotfiles/scripts/kbd.sh /usr/bin/kbd
sudo ln -s $HOME/dotfiles/scripts/np /usr/bin/np
sudo ln -s $HOME/dotfiles/scripts/put-md-to-folder.js /usr/bin/put-md-to-folder
sudo ln -s $HOME/dotfiles/scripts/add-prefixes-in-folder.js /usr/bin/add-prefixes-in-folder

sudo ln -s $HOME/dotfiles/scripts/wm/move-to-tag.sh /usr/bin/move-to-tag
sudo ln -s $HOME/dotfiles/scripts/wm/open-tag.sh /usr/bin/open-tag
sudo ln -s $HOME/dotfiles/scripts/wm/switch-to-tag.sh /usr/bin/switch-to-tag
sudo ln -s $HOME/dotfiles/scripts/pomodoro.sh /usr/bin/po
sudo ln -s $HOME/dotfiles/scripts/canonical-path.sh /usr/bin/canonical-path
sudo ln -s $HOME/dotfiles/scripts/jshift.sh /usr/bin/jshift

sudo ln -s $HOME/dotfiles/scripts/atom-open-in-terminal.sh /usr/local/bin/terminal-tab.sh

sudo mv /usr/bin/link /usr/bin/link-old
sudo ln -s $HOME/dotfiles/scripts/link.sh /usr/bin/link

sudo mv /usr/bin/xdg-open /usr/bin/xdg-open-old
sudo ln -s $HOME/dotfiles/scripts/xdg-open /usr/bin/xdg-open
sudo ln -s $HOME/dotfiles/env.desktop /usr/share/xsessions/env.desktop

DROPBOX_LINKS="$HOME/Dropbox/links.sh"
[ -f "$DROPBOX_LINKS" ] && . "$DROPBOX_LINKS" || echo "\"$DROPBOX_LINKS\" doesn't exist"
