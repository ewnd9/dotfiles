'use strict';

const fs = require('fs');
const chalk = require('chalk');
// const parse = require('parse-github-repo-url');
const execa = require('belt-tools/modules/execa');
const { evalTemplate, ensureParentDir } = require('../utils');

module.exports = {
  setup,
  extract
};

async function setup({ modules }) {
  for (const mod of modules) {
    // const repoName = parse(mod.repo)[1];
    const dest = evalTemplate(mod.dest);
    ensureParentDir(dest);

    if (!fs.existsSync(dest)) {
      await execa('git', ['clone', mod.repo, dest]);
    }

    const sha = await execa.stdout('git', ['rev-parse', 'HEAD'], { cwd: dest });

    if (sha !== mod.sha) {
      await execa('git', ['checkout', mod.sha], { cwd: dest });
    }

    console.log(`${chalk.green('✔️')} ${dest}`);
  }
}

function extract() {
  throw new Error(`not implemented`);
}
