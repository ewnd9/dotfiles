

import { execa } from 'execa';
import { logShell } from './log';

export default execaProxy;

// seems cleaner without abstractions
async function execaProxy(cmd, args, opts) {
  logShell([cmd, ...args]);
  const { stdout } = await execa(cmd, args, opts);
  return stdout;
}
