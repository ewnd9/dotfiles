'use strict';

const fs = require('fs');
const chalk = require('chalk');
const execa = require('belt-tools/modules/execa');
const { evalTemplate, ensureParentDir } = require('../utils');

module.exports = {
  setup
};

async function setup(symLinks) {
  for (const { src, dest, disable } of symLinks.targets) {
    if (disable) {
      console.log(`${chalk.grey('✔️')} ${dest} (skip)`);
      continue;
    }

    const srcPath = evalTemplate(src);
    const destPath = evalTemplate(dest);

    ensureParentDir(destPath);

    if (!fs.existsSync(destPath)) {
      await execa('ln', ['-s', srcPath, destPath]);
      console.log(`${chalk.green('✔️')} ${srcPath} -> ${destPath}`);
    } else {
      const stat = fs.lstatSync(destPath);

      if (!stat.isSymbolicLink()) {
        throw new Error(`${dest}: exists, but not a link`);
      }

      const realPath = fs.realpathSync(destPath);

      if (realPath !== srcPath) {
        throw new Error(`${dest}: sym link is refered somewhere else (${realPath} instead of ${srcPath})`);
      }

      console.log(`${chalk.green('=')} ${srcPath} -> ${destPath}`);
    }
  }
}
