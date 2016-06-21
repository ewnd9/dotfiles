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
  wmctrl

sudo add-apt-repository ppa:webupd8team/nemo
sudo add-apt-repository ppa:webupd8team/atom
sudo add-apt-repository ppa:nilarimogard/webupd8

sudo apt-get update

sudo apt-get install -y \
  nemo \
  nemo-fileroller \
  atom \
  prime-indicator \
  nvidia-settings

sudo apt-get purge -y nautilus
