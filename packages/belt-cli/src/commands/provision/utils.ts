import fs from 'node:fs';
import path from 'node:path';
import execa from '../../modules/execa.js';

const ctx = {
  HOME: process.env.HOME,
  DOTFILES: `${process.env.HOME}/dotfiles`,
};

export function evalTemplate(template: string) {
  const regExp = /\$(\w+)/g;

  return template.replace(regExp, (_match: string, group: string) => {
    const variable = (ctx as any)[group];

    if (!variable) {
      throw new Error(`unknown variable ${group}`);
    }

    return variable;
  });
}

export function ensureParentDir(filePath: string) {
  fs.mkdirSync(path.dirname(filePath), { recursive: true });
}

export function readNodeModules(dirPath: string): any[] {
  const packages = fs.readdirSync(dirPath).reduce((total: any[], dir: string) => {
    const modulePath = `${dirPath}/${dir}`;

    if (dir[0] === '@') {
      total.push.apply(total, readNodeModules(modulePath));
    } else {
      const pkgPath = `${modulePath}/package.json`;
      const pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf-8'));

      total.push(pkg);
    }

    return total;
  }, [] as any[]);

  return packages;
}

export async function readGitModules(dirPath: string) {
  const modules: any[] = [];

  for (const dir of fs.readdirSync(dirPath)) {
    const modulePath = `${dirPath}/${dir}`;
    const repo = await execa('git', ['config', '--get', 'remote.origin.url'], {
      cwd: modulePath,
    });
    const sha = await execa('git', ['rev-parse', 'HEAD'], { cwd: modulePath });

    modules.push({ repo, sha });
  }

  return modules;
}

export function readZshHistory() {
  const zshHistoryPath = `${process.env.HOME}/.zsh_history`;
  const lines = fs
    .readFileSync(zshHistoryPath, 'utf-8')
    .split('\n')
    .reduce((acc: string[], line: string) => {
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
    }, [] as string[]);

  return lines;
}
