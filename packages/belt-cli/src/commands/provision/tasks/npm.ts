import execa from '../../../modules/execa.js';
import { readNodeModules } from '../utils.js';

export async function setup({ packages }: { packages: { name: string }[] }) {
  for (const pkg of packages) {
    await execa('npm', ['install', '--global', pkg.name], { stdio: 'inherit' });
  }
}

export function extract() {
  const npmPackagesPath = `${process.env.HOME}/.npm-packages/lib/node_modules`; // @TODO: find via ~/.npmrc with fallback to default

  const packages = readNodeModules(npmPackagesPath).map((pkg) => {
    return { name: pkg.name, version: pkg.version };
  });

  return { packages };
}
