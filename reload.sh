#!/bin/bash

if [[ "$OSTYPE" == *darwin* ]]; then
  # https://github.com/pqrs-org/Karabiner-Elements/issues/848#issuecomment-616226581
  killall Karabiner-Elements; open /Applications/Karabiner-Elements.app
else
  echo "nothing yet for Linux"
fi

belt ewnd9:provision --setup symlinks
belt ewnd9:dotfiles-docs
