'use strict';

const shellEscape = require('any-shell-escape');
const chalk = require('chalk');

module.exports = {
  log,
  logShell
};

function log(str) {
  console.error(chalk.grey(str));
}

function logShell(args) {
  log(`$ ${shellEscape(args)}`);
}
