#!/bin/bash

set -e

# ===
# usage
#   "$ jshift file.js"
#   "$ jshift dir"
# transformations
#   1. replace var to let and const
# ===

FILE="$1"

transforms=(
  no-vars.js
  template-literals.js
  unchain-variables.js
)

if [ -a $FILE ]; then
  for t in "${transforms[@]}"
  do
    jscodeshift -t "$HOME/dotfiles/scripts/js-codemod/transforms/$t" $@
  done
else
  "$FILE doesn't exist"
fi
