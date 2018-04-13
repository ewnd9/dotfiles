'use strict';

const fs = require('fs');
const path = require('path');
const mkdirp = require('mkdirp');
const execa = require('belt-tools/modules/execa');

module.exports = {
  evalTemplate,
  ensureParentDir,
  readNodeModules,
  readGitModules
};

const ctx = {
  HOME: process.env.HOME,
  DOTFILES: `${process.env.HOME}/dotfiles`
};

function evalTemplate(template) {
  const regExp = /\$(\w+)/g;

  return template.replace(regExp, (match, group)  => {
    const variable = ctx[group];

    if (!variable) {
      throw new Error(`unknown variable ${group}`);
    }

    return variable;
  });
}

function ensureParentDir(filePath) {
  mkdirp.sync(path.dirname(filePath));
}

function readNodeModules(dirPath) {
  const packages = fs.readdirSync(dirPath).reduce((total, dir) => {
    const modulePath = `${dirPath}/${dir}`;

    if (dir[0] === '@') {
      total.push.apply(total, readNodeModules(modulePath));
    } else {
      const pkgPath = `${modulePath}/package.json`;
      const pkg = JSON.parse(fs.readFileSync(pkgPath));

      total.push(pkg);
    }

    return total;
  }, []);

  return packages;
}

async function readGitModules(dirPath) {
  const modules = [];

  for (const dir of fs.readdirSync(dirPath)) {
    const modulePath = `${dirPath}/${dir}`;
    const repo = await execa.stdout('git', ['config', '--get', 'remote.origin.url'], { cwd: modulePath });
    const sha = await execa.stdout('git', ['rev-parse', 'HEAD'], { cwd: modulePath });

    modules.push({ repo, sha });
  }

  return modules;
}
