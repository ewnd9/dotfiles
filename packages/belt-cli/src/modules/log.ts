

import shellEscape from 'any-shell-escape';
import chalk from 'chalk';

export default {
  log,
  logShell
};

function log(str) {
  console.error(chalk.grey(str));
}

function logShell(args) {
  log(`$ ${shellEscape(args)}`);
}
