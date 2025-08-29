

import fs from 'fs';
import path from 'path';
import mkdirp from 'mkdirp';
import execa from '../modules/execa';

export default {
  evalTemplate,
  ensureParentDir,
  readNodeModules,
  readGitModules,
  readZshHistory,
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

function readZshHistory() {
  const zshHistoryPath = `${process.env.HOME}/.zsh_history`;
  const lines = fs.readFileSync(zshHistoryPath, 'utf-8').split('\n').reduce((acc, line) => {
    if (line[0] === ':') {
      line = line.substring(line.indexOf(';') + 1);
    }

    const prevLine = acc[acc.length - 1] || '';

    if (prevLine.substring(prevLine.length - 2) === '\\\\') {
      acc[acc.length - 1] = prevLine.substring(0, prevLine.length - 2) + line;
    } else {
      acc.push(line);
    }

    return acc;
  }, []);

  return lines;
}
