'use strict';

const execa = require('../modules/execa');
const opn = require('../modules/opn');

const gitUrlParse = require('git-url-parse');

module.exports = {
  run
};

async function run({ argv }) {
  const remoteUrl = await execa('git', ['remote', 'get-url', argv.origin || 'origin']);
  const { resource, owner, name } = gitUrlParse(remoteUrl);

  const url = `http://${resource}/${owner}/${name}`;
  opn(url);
}
