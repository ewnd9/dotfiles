#!/bin/sh

apm install expand-region
apm install git-tab-status
apm install autocomplete-emojis
apm install language-lua
apm install pigments
apm install react
apm install markdown-preview-plus
apm install open-terminal-here
apm install hyperclick
apm install js-hyperclick

apm install modular-snippets
rm -rf ~/.atom/packages/modular-snippets/snippets
ln -s $HOME/dotfiles/config/atom/snippets $HOME/.atom/packages/modular-snippets/snippets
