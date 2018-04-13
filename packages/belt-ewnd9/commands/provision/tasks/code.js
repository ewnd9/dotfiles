'use strict';

// https://code.visualstudio.com/docs/editor/extension-gallery

const { readNodeModules } = require('../utils');

module.exports = {
  setup,
  extract
};

async function setup({ extensions }) {
  for (const ext of extensions) {
    await execa('code', ['--install-extension', `${ext.publisher}.${ext.name}`], { stdio: 'inherit' });
  }
}

function extract() {
  const codeExtensionsPath = `${process.env.HOME}/.vscode/extensions`;

  const packages = readNodeModules(codeExtensionsPath).map(pkg => {
    return { name: pkg.name, publisher: pkg.publisher, version: pkg.version };
  });

  return { extensions };
}
