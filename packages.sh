#!/bin/sh

sudo apt-get install -y chromium-browser
sudo apt-get install -y terminator
sudo apt-get install -y awesome awesome-extra xcompmgr wmname
sudo apt-get install -y zsh
sudo apt-get install -y guake
sudo apt-get install -y vlc

sudo add-apt-repository ppa:webupd8team/nemo
sudo add-apt-repository ppa:webupd8team/atom
sudo add-apt-repository ppa:webupd8team/java
sudo add-apt-repository ppa:skunk/pepper-flash

sudo apt-get update

sudo apt-get install -y nemo nemo-fileroller
sudo apt-get install -y atom
sudo apt-get install -y oracle-java8-installer
sudo apt-get install -y pepflashplugin-installer

# ruby 

git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
exec $SHELL
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
exec $SHELL
rbenv install 2.1.5
rbenv global 2.1.5
ruby -v

# node

sudo apt-get install -y nodejs npm

npm config set prefix '~/.npm-packages'

npm install -g fkill-cli
npm install -g brightness-cli

npm install -g yo
npm link /home/ewnd9/dotfiles/yo-generators/generator-ewnd9
