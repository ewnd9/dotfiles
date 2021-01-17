# dotfiles

awesome-wm, atom, gnome-terminal, vim, tmux, zsh

![screen](/screen.png?raw=true)

## Overview

### Terminal

`gnome-terminal` with [Atom's One Dark theme](https://github.com/denysdovhan/one-gnome-terminal)

### Vim

plugin manager [pathogen](https://github.com/tpope/vim-pathogen)

### Window Manager

awesome wm 4.x.x with `xcompmgr` composition

## Install

### Preparation

```sh
$ sudo apt update
$ sudo apt upgrade
$ sudo apt install git vim neovim make
```

```sh
$ git clone https://github.com/ewnd9/dotfiles.git
$ ./init.sh
```

- manual-install: [google-chrome](https://www.google.ru/chrome/browser/desktop/)

- manual-install: [dropbox](https://www.dropbox.com)

- manual-install: `arc-theme`
  - Open `gnome-tweaks`
    - Themes -> `Arc-Dark`
    - Icons -> `Ubuntu-mono-dark`

- manual setup: zsh

```sh
$ chsh -s $(which zsh)
```

- manual-install: [gnome-terminal atom dark one theme](https://github.com/denysdovhan/one-gnome-terminal)

```sh
$ wget https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-dark.sh && . one-dark.sh
```

`Edit -> Profiles -> Select as default`

## Credits

- [`config/awesome-4.0/theme/mountains.jpg`](https://wallpaperscraft.com/download/mountains_paraglider_top_121654/1920x1200)

## Temporary Chrome Extensions

- [Octo Tree](https://chrome.google.com/webstore/detail/octotree/bkhaagjahfmjljalopjnoealnfndnagc?hl=ru)
- [Full Page Screen Capture](https://chrome.google.com/webstore/detail/full-page-screen-capture/fdpohaocaechififmbbbbbknoalclacl)
- [Apollo Client Developer Tools](https://chrome.google.com/webstore/detail/apollo-client-developer-t/jdkknkkbebbapilgoeccciglkfbmbnfm)
- [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en)
- [SurfingKeys](https://github.com/brookhong/Surfingkeys)
- [HabitLab](https://chrome.google.com/webstore/detail/habitlab/obghclocpdgcekcognpkblghkedcpdgd?hl=en)

## Xtra

```sh
$ echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```
