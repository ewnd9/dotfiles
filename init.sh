#!/bin/sh

set -e

cd ~
rm -rf Desktop Music Public Videos Documents examples.desktop Templates

sudo apt-get update && sudo apt-get upgrade
sudo apt-get install -y git vim-gtk

# git clone https://github.com/ewnd9/dotfiles.git
cd dotfiles

# curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
# sudo apt-get install -y nodejs

# sudo apt-key adv --fetch-keys http://dl.yarnpkg.com/debian/pubkey.gpg
# echo "deb http://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# sudo apt-get update -qq
# sudo apt-get install -y -qq yarn

yarn install
yarn global add @belt/cli
~/.npm-packages/bin/belt link packages/belt-ewnd9

~/.npm-packages/bin/belt provision --setup apt
~/.npm-packages/bin/belt provision --setup symlinks
~/.npm-packages/bin/belt provision --setup submodules
~/.npm-packages/bin/belt provision --setup npm
~/.npm-packages/bin/belt provision --setup code
~/.npm-packages/bin/belt provision --setup atom

# change default shell to zsh
chsh -s /bin/zsh

# install gnome-terminal theme, needed to applied after install (`Edit -> Profiles -> Select as default`)
./scripts/gnome-terminal-themes/one-dark.sh
gsettings set org.gnome.settings-daemon.plugins.keyboard active false # https://askubuntu.com/questions/451945/permanently-set-keyboard-layout-options-with-setxkbmap-in-gnome-unity
