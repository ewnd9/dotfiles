'use strict';

const path = require('path');
const execa = require('belt-tools/modules/execa');
const globby = require('globby');
const rootPath = path.resolve(`${__dirname}/../../..`);

module.exports = {
  run
};

async function run() {
  const files = await globby(['scripts/**/*.sh', '!scripts/gnome-terminal-themes/one-dark.sh'], {
    cwd: rootPath,
    gitignore: true
  });

  await execa('shellcheck', [...files], { cwd: rootPath, stdio: 'inherit' });
}
