#!/usr/bin/env node

'use strict';

const fs = require('fs');
const path = require('path');

const root = process.cwd();
const dir = path.basename(root);

function rename(src, dst) {
  console.log(`${src} -> ${dst}`);
  fs.renameSync(src, dst);
};

fs.readdirSync(root).forEach(file => {
  if (file[0] !== '_' && file.indexOf('.md') === file.length - 3 && file.indexOf(dir) !== 0) {
    rename(root + '/' + file, root + '/' + dir + '-' + file);
  }
});
