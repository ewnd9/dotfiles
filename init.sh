#!/bin/bash

set -ex

bash vendor/volta.sh
volta install node@14
volta install yarn
npm config set prefix $HOME/.npm-packages

if [[ "$OSTYPE" == *darwin* ]]; then
  bash vendor/brew.sh
else
  cd $HOME
  rm -rf Desktop Music Public Videos Documents examples.desktop Templates
  cd $HOME/dotfiles

  sudo apt-get update && sudo apt-get upgrade
  sudo apt-get install -y -qq git vim-gtk

  sudo apt-add-repository ppa:neovim-ppa/stable
  sudo apt-get update -qq
  sudo apt-get install -y -qq neovim
fi

yarn install
yarn global add @belt/cli
$HOME/.config/yarn/global/node_modules/.bin/belt link packages/belt-ewnd9

$HOME/.config/yarn/global/node_modules/.bin/belt ewnd9:provision --setup apt
$HOME/.config/yarn/global/node_modules/.bin/belt ewnd9:provision --setup symlinks
$HOME/.config/yarn/global/node_modules/.bin/belt ewnd9:provision --setup submodules
$HOME/.config/yarn/global/node_modules/.bin/belt ewnd9:provision --setup npm
$HOME/.config/yarn/global/node_modules/.bin/belt ewnd9:provision --setup code

if [[ "$OSTYPE" == *darwin* ]]; then
  $HOME/.config/yarn/global/node_modules/.bin/belt ewnd9:provision --setup brew
else
  # firecode
  mkdir -p  ~/.local/share/fonts

  for type in Bold Light Medium Regular Retina; do
    wget -O ~/.local/share/fonts/FiraCode-${type}.ttf \
      "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true";
  done

  fc-cache -f

  # change default shell to zsh
  chsh -s /bin/zsh
fi

# # install gnome-terminal theme, needed to applied after install (`Edit -> Profiles -> Select as default`)
# ./scripts/gnome-terminal-themes/one-dark.sh
# gsettings set org.gnome.settings-daemon.plugins.keyboard active false # https://askubuntu.com/questions/451945/permanently-set-keyboard-layout-options-with-setxkbmap-in-gnome-unity
