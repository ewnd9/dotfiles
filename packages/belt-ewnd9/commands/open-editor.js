'use strict';

const execa = require('belt-tools/modules/execa');

module.exports = {
  run
};

// @TODO: sync about rotating active editors,
// if there is an editor on 2nd tag, move it to the 4th and open new on the 2nd
async function run({ argv }) {
  const app = argv._[0] || 'code';
  let tag = 1;

  if (typeof argv._[1] !== 'undefined') {
    tag = +argv._[1];
  } else {
    const res = await execa.shell('wmctrl -l | awk \'{print $2}\' | grep 1 | wc -l');
    const count = +res.stdout;

    if (count > 0) {
      tag = 3;
    }
  }

  await execa('wmctrl', ['-s', tag]);
  await execa(app, [process.cwd()]);
}

