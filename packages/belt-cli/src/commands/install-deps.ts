import fs from 'node:fs/promises';
import path from 'node:path';
import { traverse } from 'babel-core';
import { parse } from 'babylon';
import builtinModules from 'builtin-modules';
import { globby } from 'globby';
import type { Ctx } from '../interface.js';

export async function run({ argv }: Ctx) {
  const cwd = path.resolve(process.cwd(), argv._[0] || '.');
  const files = await globby('**/*.js', {
    cwd,
    ignore: ['node_modules/**'],
    absolute: true,
    gitignore: true,
  });
  const pkg = require(`${cwd}/package.json`);
  const pkgDeps = Object.assign({}, pkg.dependencies, pkg.devDependencies);
  const res = [];

  for (const file of files) {
    const content = await fs.readFile(file, 'utf-8');
    const ast = parse(content);
    const deps = getDeps(ast);
    const external = deps.filter((dep) => dep && !dep.startsWith('.') && !builtinModules.includes(dep));

    for (const dep of external) {
      if (pkgDeps[dep]) {
        continue;
      }

      res.push(dep);
    }
  }

  console.log(res.join(' '));
}

function getDeps(ast: any) {
  const deps: string[] = [];

  traverse(ast, {
    CallExpression({ node }: { node: any }) {
      if (node.callee.name === 'require' && node.arguments[0].value) {
        const val = node.arguments[0].value;

        if (val.startsWith('@')) {
          deps.push(val.split('/').slice(0, 2).join('/'));
        } else {
          deps.push(val.split('/')[0]);
        }
      }
    },
  });

  return deps;
}
