#!/bin/sh

sudo apt-get install -y \
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
	git-extras

sudo add-apt-repository ppa:webupd8team/nemo
sudo add-apt-repository ppa:webupd8team/atom
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt-add-repository ppa:git-core/ppa

sudo apt-get update

sudo apt-get install -y \
  nemo \
  nemo-fileroller \
  atom \
  prime-indicator \
  nvidia-settings \
  git

sudo apt-get purge -y nautilus
