#!/bin/bash

./node_modules/.bin/trash node_modules &>/dev/null;
#git pull --rebase &&
#npm install &&
#npm test &&
npm version ${1:-patch} &&
npm publish &&
git push origin --follow-tags