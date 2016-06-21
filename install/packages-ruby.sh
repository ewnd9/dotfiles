#!/bin/sh

git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
exec $SHELL
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
exec $SHELL
rbenv install 1.1.5
rbenv global 2.1.5
ruby -v

