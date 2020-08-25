#!/bin/bash

set -ex

cd ~
# rm -rf Desktop Music Public Videos Documents examples.desktop Templates

# sudo apt-get update && sudo apt-get upgrade
# sudo apt-get install -y git vim-gtk

# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# node
curl https://get.volta.sh | bash
volta install node@14
volta install yarn
npm config set prefix $HOME/.npm-packages

## yarn
curl -o- -L https://yarnpkg.com/install.sh | bash

## brew
brew install kubectl

# # git clone https://github.com/ewnd9/dotfiles.git
# cd ~/dotfiles

# sudo apt-add-repository ppa:neovim-ppa/stable
# sudo apt-key adv --fetch-keys http://dl.yarnpkg.com/debian/pubkey.gpg
# echo "deb http://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# sudo apt-get update -qq
# sudo apt-get install -y -qq yarn neovim

yarn install
yarn global add @belt/cli
~/.config/yarn/global/node_modules/.bin/belt link packages/belt-ewnd9

~/.config/yarn/global/node_modules/.bin/belt ewnd9:provision --setup apt
~/.config/yarn/global/node_modules/.bin/belt ewnd9:provision --setup symlinks
~/.config/yarn/global/node_modules/.bin/belt ewnd9:provision --setup submodules
~/.config/yarn/global/node_modules/.bin/belt ewnd9:provision --setup npm
~/.config/yarn/global/node_modules/.bin/belt ewnd9:provision --setup code

# # firecode
# mkdir -p  ~/.local/share/fonts
# for type in Bold Light Medium Regular Retina; do
#   wget -O ~/.local/share/fonts/FiraCode-${type}.ttf \
#     "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true";
# done
# fc-cache -f

# # change default shell to zsh
# chsh -s /bin/zsh

# # install gnome-terminal theme, needed to applied after install (`Edit -> Profiles -> Select as default`)
# ./scripts/gnome-terminal-themes/one-dark.sh
# gsettings set org.gnome.settings-daemon.plugins.keyboard active false # https://askubuntu.com/questions/451945/permanently-set-keyboard-layout-options-with-setxkbmap-in-gnome-unity
