#!/usr/bin/env node

const fs = require('fs');
const root = process.cwd();

fs.readdirSync(root).forEach(file => {
  if (file[0] !== '_' && file.indexOf('.md') === file.length - 3) {
    const dir = file.substr(0, file.length - 3);
    fs.mkdirSync(root + '/' + dir);
    fs.renameSync(root + '/' + file, root + '/' + dir + '/' + file);
  }
})
