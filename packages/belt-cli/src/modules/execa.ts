import { execa as ogExeca } from 'execa';
import { logShell } from "./log.js";

// seems cleaner without abstractions
export default async function execaProxy(cmd: string, args: string[], opts?: any) {
  logShell([cmd, ...args]);
  const { stdout } = await ogExeca(cmd, args, opts);
  return stdout;
}
