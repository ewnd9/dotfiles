'use strict';

const { execa } = require('execa');
const { logShell } = require('./log');

module.exports = execaProxy;

// seems cleaner without abstractions
async function execaProxy(cmd, args, opts) {
  logShell([cmd, ...args]);
  const { stdout } = await execa(cmd, args, opts);
  return stdout;
}
