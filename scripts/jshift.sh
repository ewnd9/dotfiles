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
  js-codemod-cpojer/transforms/no-vars.js
  js-codemod-cpojer/transforms/template-literals.js
  js-codemod-cpojer/transforms/unchain-variables.js
)

if [ -a $FILE ]; then
  for t in "${transforms[@]}"
  do
    jscodeshift -t "$HOME/dotfiles/scripts/codemod/$t" $@
  done
else
  "$FILE doesn't exist"
fi
