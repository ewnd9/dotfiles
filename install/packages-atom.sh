#!/bin/sh

apm install expand-region
apm install autocomplete-emojis
apm install language-lua
apm install pigments
apm install react
apm install markdown-preview-plus
apm install open-terminal-here
apm install hyperclick
apm install js-hyperclick
apm install hyperclick-markdown
apm install toggle-quotes
apm install autocomplete-modules
apm install synced-sidebar
apm install sort-lines
apm install nice-index
apm install merge-conflicts
apm install pretty-json
apm install split-diff
apm install markdown-toc
apm install ewnd9/language-babel
apm install ewnd9/autocomplete-flow

apm install linter
apm install ewnd9/linter-eslint


apm install https://github.com/thibmaek/modular-snippets
rm -rf ~/.atom/packages/modular-snippets/snippets
ln -s $HOME/dotfiles/config/atom/snippets $HOME/.atom/packages/modular-snippets/snippets
