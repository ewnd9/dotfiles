'use strict';

const fs = require('fs');
const { promisify: pify } = require('util');
const readFile = pify(fs.readFile);
const path = require('path');

const { parse } = require('babylon');
const { traverse } = require('babel-core');
const builtinModules = require('builtin-modules');
const globby = require('globby');

module.exports = {
  run
};

async function run({ argv }) {
  const cwd = path.resolve(process.cwd(), argv._[0] || '.');
  const files = await globby('**/*.js', { cwd, ignore: ['node_modules/**'], absolute: true, gitignore: true });
  const pkg = require(`${cwd}/package.json`);
  const pkgDeps = Object.assign({}, pkg.dependencies, pkg.devDependencies);
  const res = [];

  for (const file of files) {
    const content = await readFile(file, 'utf-8');
    const ast = parse(content);
    const deps = getDeps(ast);
    const external = deps.filter(dep => dep && !dep.startsWith('.') && !builtinModules.includes(dep));

    for (const dep of external) {
      if (pkgDeps[dep]) {
        continue;
      }

      res.push(dep);
    }
  }

  console.log(res.join(' '));
}

function getDeps(ast) {
  const deps = [];

  traverse(ast, {
    CallExpression({ node }) {
      if (node.callee.name === 'require' && node.arguments[0].value) {
        const val = node.arguments[0].value;

        if (val.startsWith('@')) {
          deps.push(val.split('/').slice(0, 2).join('/'));
        } else {
          deps.push(val.split('/')[0]);
        }
      }
    }
  });

  return deps;
}
