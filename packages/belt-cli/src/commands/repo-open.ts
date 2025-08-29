

import execa from '../modules/execa';
import opn from '../modules/opn';
import gitUrlParse from 'git-url-parse';

export default {
  run
};

async function run({ argv }) {
  const remoteUrl = await execa('git', ['remote', 'get-url', argv.origin || 'origin']);
  const { resource, owner, name } = gitUrlParse(remoteUrl);

  const url = `http://${resource}/${owner}/${name}`;
  opn(url);
}
