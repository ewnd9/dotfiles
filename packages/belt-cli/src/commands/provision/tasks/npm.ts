

import execa from '../modules/execa';
import { readNodeModules } from '../utils';

export default {
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
