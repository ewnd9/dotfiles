'use strict';

const { readNodeModules } = require('../utils');

module.exports = {
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
