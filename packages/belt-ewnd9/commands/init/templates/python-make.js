'use strict';

const fs = require('fs');
const dedent = require('dedent');

const execa = require('belt-tools/modules/execa');

module.exports = {
  run
};

async function run() {
  fs.writeFileSync('Makefile', getMakefile());
  fs.writeFileSync('main.py', getMainPy());
  fs.writeFileSync('Pipfile', getPipFile());
  fs.writeFileSync('.gitignore', getGitIgnore());

  await execa('pipenv', ['install']);
}

function getMakefile() {
  return dedent`
    format:
    	pipenv run autopep8 --in-place **/*.py
  `;
}

function getMainPy() {
  return dedent`
    print('hello world')
  `;
}

function getPipFile() {
  return dedent`
    [[source]]

    verify_ssl = true
    name = "pypi"
    url = "https://pypi.python.org/simple"


    [dev-packages]

    "autopep8" = "*"


    [packages]
  `;
}

function getGitIgnore() {
  return dedent`
    __pycache__
  `;
}
