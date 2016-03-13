#!/bin/sh

sudo apt-get update && sudo apt-get upgrade

sudo apt-get install -y awesome awesome-extra xcompmgr wmname
sudo apt-get install -y zsh
sudo apt-get install -y guake
sudo apt-get install -y vlc
sudo apt-get install -y tmux
sudo apt-get install -y vim
sudo apt-get install -y trash-cli
sudo apt-get install -y indicator-cpufreq
sudo apt-get install -y g++
sudo apt-get install -y ncdu
sudo apt-get install -y xbacklight
sudo apt-get install -y httpie
sudo apt-get install -y cloc
sudo apt-get install -y wordnet
sudo apt-get install -y jq 

sudo add-apt-repository ppa:webupd8team/nemo
sudo add-apt-repository ppa:webupd8team/atom
sudo add-apt-repository ppa:skunk/pepper-flash
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo add-apt-repository ppa:tualatrix/ppa

sudo apt-get update

sudo apt-get install -y nemo nemo-fileroller
sudo apt-get purge -y nautilus

sudo apt-get install -y atom
sudo apt-get install -y pepflashplugin-installer
sudo apt-get install -y albert
sudo apt-get install -y ubuntu-tweak

# ruby

git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
exec $SHELL
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
exec $SHELL
rbenv install 2.1.5
rbenv global 2.1.5
ruby -v

# node 5.x

curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
sudo apt-get install -y nodejs

npm config set prefix '~/.npm-packages'
npm set init-author-name ewnd9
npm set init-author-email ewndnine@gmail.com
npm set init-license MIT

# node packages

npm install -g fkill-cli
npm install -g yo

# my stuff
npm install -g dictionary-cli
npm install -g yo

