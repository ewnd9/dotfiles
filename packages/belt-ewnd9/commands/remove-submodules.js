'use strict';

const fs = require('fs');
const chalk = require('chalk');
const execa = require('belt-tools/modules/execa');

module.exports = {
  run
};

async function run() {
  const data = fs.readFileSync('.gitmodules', 'utf-8').split('\n');

  for (const line of data) {
    const m = line.match(/path = (.+)$/);

    if (!m) {
      continue;
    }

    const dest = m[1];

    try {
      await execa('git', ['submodule', 'deinit', '-f', dest]);
      await execa('git', ['rm', '-f', dest]);

      console.log(`${chalk.green('✔️')} ${dest}`);
    } catch (err) {
      console.error(err);
    }
  }
}
