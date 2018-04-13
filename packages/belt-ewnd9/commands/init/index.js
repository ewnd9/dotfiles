'use strict';

module.exports = {
  run
};

async function run({ argv }) {
  const cmd = argv._[0];

  if (cmd === 'c') {
    require('./templates/c-make').run({ argv });
  } else {
    throw new Error(`unknown project type "${cmd}"`);
  }
}
