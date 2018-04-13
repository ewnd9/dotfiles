'use strict';

const execa = require('belt-tools/modules/execa');
const { readNodeModules } = require('../utils');

module.exports = {
  setup,
  extract
};

async function setup({ packages }) {
  for (const pkg of packages) {
    await execa('npm', ['install', '--global', pkg.name], { stdio: 'inherit' });
  }
}

function extract() {
  const npmPackagesPath = `${process.env.HOME}/.npm-packages/lib/node_modules`; // @TODO: find via ~/.npmrc with fallback to default

  const packages = readNodeModules(npmPackagesPath).map(pkg => {
    return { name: pkg.name, version: pkg.version };
  });

  return { packages };
}
