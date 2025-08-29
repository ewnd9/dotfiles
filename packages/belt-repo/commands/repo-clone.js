'use strict';

const fs = require('fs');
const path = require('path');
const gitUrlParse = require('git-url-parse');

const Gitlab = require('../providers/gitlab-provider');
const Github = require('../providers/github-provider');

module.exports = {
  run
};

async function run({ argv: { _: queries, output, schema = 'ssh', depth, manifest }, ensureConfig }) {
  // if (argv._.length !== 2) {
  //   throw new Error(`Usage: $ belt repo:belt-command <namespace>:<name> '<description>'`);
  // }
  const rootDir = output ? path.resolve(output) : process.cwd();
  const projects = [];

  for (const query of queries) {
    const provider = await getProvider(query);
    const { owner, name } = gitUrlParse(query);
    projects.push(...(await provider.getAllProjects({ owner, name })));
  }

  fs.writeFileSync(
    'manifest.json',
    JSON.stringify({ queries, schema, depth, output, projects }, null, 2)
  );

  if (manifest) {
    return;
  }

  for (const project of projects) {
    const url = project.httpsUrl;
    const provider = await getProvider(url);
    const { resource } = gitUrlParse(url);

    await provider.cloneProject({
      project,
      output: `${rootDir}/${resource}`,
      schema,
      depth
    });
  }

  async function getProvider(query) {
    const { resource } = gitUrlParse(query);
    const key = `token-${resource}`;
    const config = await ensureConfig('repo-clone', {
      [key]: {
        type: 'password',
      }
    });

    const token = config[key];

    if (resource.includes('gitlab')) {
      return Gitlab.getProviderByHostname({ host: resource, token });
    } else if (resource.includes('github')) {
      return Github.getProviderByHostname({ host: resource, token });
    } else {
      throw new Error(`Unknown resource: "${resource}"`);
    }
  }
}
