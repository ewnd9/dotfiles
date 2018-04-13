'use strict';

const fs = require('fs');
const dedent = require('dedent');

module.exports = {
  run
};

async function run() {
  fs.writeFileSync('index.js', getIndex());
  fs.writeFileSync('package.json', getPackageJSON());
  fs.writeFileSync('.gitignore', getGitIgnore());
}

function getIndex() {
  return dedent`
    'use strict';\n\n
  `;
}

function getPackageJSON() {
  return dedent`
    {
      "private": true
    }
  `;
}

function getGitIgnore() {
  return dedent`
    node_modules
  `;
}
