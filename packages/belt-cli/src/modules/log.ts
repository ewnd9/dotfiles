import shellEscape from 'any-shell-escape';
import chalk from 'chalk';

export function log(str: string) {
  console.error(chalk.grey(str));
}

export function logShell(args: string[]) {
  log(`$ ${shellEscape(args)}`);
}
