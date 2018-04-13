'use strict';

const execa = require('belt-tools/modules/execa');
const { readNodeModules } = require('../utils');

module.exports = {
  setup,
  extract
};

async function setup({ packages }) {
  for (const pkg of packages) {
    await execa('apm', ['install', pkg.name], { stdio: 'inherit' });
  }
}

function extract() {
  const atomPackagesPath = `${process.env.HOME}/.atom/packages`;

  const packages = readNodeModules(atomPackagesPath).map(pkg => {
    return { name: pkg.name, version: pkg.version };
  });

  return { packages };
}
