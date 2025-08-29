

import execa from "../modules/execa.js";
import opn from "../modules/opn.js";
import gitUrlParse from 'git-url-parse';

export async function run({ argv }: { argv: any }) {
  const remoteUrl = (await execa('git', ['remote', 'get-url', argv.origin || 'origin'], {})) || '';
  const { resource, owner, name } = gitUrlParse(remoteUrl);

  const url = `http://${resource}/${owner}/${name}`;
  opn(url, {});
}
