#!/bin/sh

DEST="$HOME/.config/hain-user/devplugins"
cd $DEST

git clone https://github.com/ewnd9/hain-plugin-chrome-bookmarks.git
cd hain-plugin-chrome-bookmarks
npm install
