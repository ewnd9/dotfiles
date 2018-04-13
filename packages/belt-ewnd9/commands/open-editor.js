'use strict';

const execa = require('belt-tools/modules/execa');

module.exports = {
  run
};

async function run({ argv }) {
  let tag = 1;

  const res = await execa.shell('wmctrl -l | awk \'{print $2}\' | grep 1 | wc -l');
  const count = +res.stdout;

  if (count > 0) {
    tag = 3;
  }

  await execa('wmctrl', ['-s', tag]);
  await execa(argv._[0] || 'code', [process.cwd()]);
}

