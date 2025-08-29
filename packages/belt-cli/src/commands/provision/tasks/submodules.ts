import fs from 'fs';
import chalk from 'chalk';

// const parse = require('parse-github-repo-url');
import execa from "../../../modules/execa.js";

import { evalTemplate, ensureParentDir } from "../utils.js";

export async function setup({
  modules,
}: {
  modules: { repo: string; sha: string; dest: string }[];
}) {
  for (const mod of modules) {
    // const repoName = parse(mod.repo)[1];
    const dest = evalTemplate(mod.dest);
    ensureParentDir(dest);

    if (!fs.existsSync(dest)) {
      await execa('git', ['clone', mod.repo, dest]);
    }

    const sha = await execa('git', ['rev-parse', 'HEAD'], { cwd: dest });

    if (sha !== mod.sha) {
      await execa('git', ['checkout', mod.sha], { cwd: dest });
    }

    console.log(`${chalk.green('✔️')} ${dest}`);
  }
}

export function extract() {
  throw new Error(`not implemented`);
}
