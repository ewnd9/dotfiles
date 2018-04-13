'use strict';

const execa = require('belt-tools/modules/execa');

module.exports = {
  run
};

async function run({ argv }) {
  const file = argv._[0];
  const strCase = argv._[1] || 'kebab';

  const transform = require(`lodash/fp/${strCase}Case`);
  const newFile = file.split('.').map(part => transform(part)).join('.');

  await execa('mv', [file, newFile]);
}

