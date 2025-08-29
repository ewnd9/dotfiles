import ogOpn from 'opn';
import { logShell } from "./log.js";

export default function opn(url: string, opts?: any) {
  // sorry windows, it's complex https://github.com/sindresorhus/opn/blob/cfab3f9ba2096b00fef655f454be65b070f49d8a/index.js#L34
  const cmd = process.platform === 'darwin' ? 'open' : 'xdg-open';
  logShell([cmd, url]);

  return ogOpn(url, opts);
}
