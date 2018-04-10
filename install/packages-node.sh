#!/bin/sh

git clone https://github.com/tj/n.git /tmp/n
cd /tmp/n
sudo make install

sudo n 8.9.1

npm config set prefix '~/.npm-packages'
npm set init-author-name ewnd9
npm set init-author-email ewndnine@gmail.com
npm set init-license MIT

# node packages

npm install -g yarn
npm install -g fkill-cli
npm install -g yo
npm install -g travis-encrypt
npm install -g jscodeshift
npm install -g changelog
npm install -g npm-check
npm install -g detect-import-require
npm install -g tldr
npm install -g strip-json-comments-cli

# my stuff

npm install -g dictionary-cli
npm install -g cached-npm-repo
npm install -g cached-npm-install
npm install -g anki-apkg-export-cli
