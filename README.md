# dotfiles

awesome-wm, atom, gnome-terminal, vim, tmux, zsh

![screen](/screen.png?raw=true)

## Overview

### Terminal

used to use `terminator`, now back to `gnome-terminal` with [Atom's One Dark theme](https://github.com/denysdovhan/one-gnome-terminal)

### Vim

plugin manager [pathogen](https://github.com/tpope/vim-pathogen)

### Window Manager

awesome wm 3.4.x with `xcompmgr` composition

## Install

```sh
$ cd ~
$ rm -rf Desktop Music Public Videos Documents examples.desktop Templates

$ sudo apt-get update && sudo apt-get upgrade
$ sudo apt-get install -y git vim-gtk

$ git clone https://github.com/ewnd9/dotfiles.git
$ cd dotfiles
$ git submodule init && git submodule update

$ ./install/packages.sh
$ ./install/packages-node.sh
$ ./install/packages-awesome.sh
$ ./install/packages-ruby.sh
$ ./install/packages-atom.sh

$ ./linking-user.sh
$ ./linking-scripts.sh
$ ./linking-sudo.sh

# change default shell to zsh
$ chsh -s /bin/zsh

# install gnome-terminal theme, needed to applied after install (`Edit -> Profiles -> Select as default`)
$ ./scripts/gnome-terminal-themes/one-dark.sh
```

- manual-install: [google-chrome](https://www.google.ru/chrome/browser/desktop/)

- manual-install: [dropbox](https://www.dropbox.com)
