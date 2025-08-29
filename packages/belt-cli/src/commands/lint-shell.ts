

import path from 'path';
import execa from "../modules/execa.js";
import { globby } from 'globby';
const rootPath = path.resolve(`${__dirname}/../../..`);

export async function run() {
  const files = await globby(['scripts/**/*.sh', '!scripts/gnome-terminal-themes/one-dark.sh'], {
    cwd: rootPath,
    gitignore: true
  });

  await execa('shellcheck', [...files], { cwd: rootPath, stdio: 'inherit' });
}
