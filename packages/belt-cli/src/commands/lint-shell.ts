import path, { dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

import { globby } from 'globby';
import execa from '../modules/execa.js';

const __dirname = dirname(fileURLToPath(import.meta.url));
const rootPath = path.resolve(`${__dirname}/../../../..`);

export async function run() {
  const files = await globby(['scripts/**/*.sh', '!scripts/gnome-terminal-themes/one-dark.sh'], {
    cwd: rootPath,
    gitignore: true,
  });

  await execa('shellcheck', [...files], { cwd: rootPath, stdio: 'inherit' });
}
