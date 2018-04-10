#!/bin/sh

sudo apt-get install -y \
  traceroute \
  ranger \
  awesome \
  awesome-wm \
  xcompmgr \
  wmname \
  zsh \
  guake \
  vlc \
  tmux \
  trash-cli \
  indicator-cpufreq \
  g++ \
  wordnet \
  jq \
  anki \
  ncdu \
  cmake \
  xbacklight \
  xdotool \
  wmctrl \
  unity-tweak-tool \
  git \
  git-extras \
  redshift \
  redshift-gtk

sudo add-apt-repository ppa:webupd8team/nemo
sudo add-apt-repository ppa:webupd8team/atom
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt-add-repository ppa:git-core/ppa
sudo add-apt-repository ppa:zeal-developers/ppa
sudo add-apt-repository ppa:neovim-ppa/stable

sudo apt-get update

sudo apt-get install -y \
  nemo \
  nemo-fileroller \
  atom \
  prime-indicator \
  nvidia-settings \
  git \
  zeal \
  neovim

sudo apt-get purge -y nautilus
