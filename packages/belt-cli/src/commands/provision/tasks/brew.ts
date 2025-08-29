

import prompts from 'prompts';
import execa from '../modules/execa';
import uniq from 'lodash/uniq';
import { readZshHistory } from '../utils';

export default {
  setup,
  extract,
};

async function setup({ packages, repositories, cask }) {
  for (const repo of repositories) {
    await execa('brew', ['tap', repo.name], { stdio: 'inherit' });
  }
  await execa('brew', ['install', ...packages.map(pkg => pkg.name)], { stdio: 'inherit' });
  await execa('brew', ['install', ...cask.map(pkg => pkg.name), '--cask'], { stdio: 'inherit' });
}

async function extract(opts) {
  const lines = readZshHistory();

  await parseMissingCommands(
    lines,
    'brew install',
    pkg => `Add "brew install ${pkg}"?`,
    opts.packages
  );

  await parseMissingCommands(
    lines,
    'brew cask install',
    pkg => `Add "brew cask install ${pkg}"?`,
    opts.cask
  );

  await parseMissingCommands(
    lines,
    'brew tap',
    pkg => `Add "brew tap ${pkg}"?`,
    opts.repositories
  );

  return opts;
}

async function parseMissingCommands(lines, pattern, buildMessage, source) {
  const pkgs = uniq(
    lines
      .filter(line => line.startsWith(pattern))
      .map(line => line.substring(pattern.length + 1))
      .flatMap(line => line.split(/\s+/g))
  );

  const missingPkgs = pkgs.filter(
    pkg => !source.some(({ name }) => name === pkg)
  );

  for (const pkg of missingPkgs) {
    const { value } = await prompts({
      type: 'confirm',
      name: 'value',
      message: buildMessage(pkg),
      initial: true,
    });

    if (value) {
      source.push({ name: pkg });
    }
  }
}
