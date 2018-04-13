'use strict';

const fs = require('fs');
const dedent = require('dedent');

module.exports = {
  run
};

async function run() {
  fs.writeFileSync('Makefile', getMakefile());
  fs.writeFileSync('main.c', getMainC());
  fs.writeFileSync('.gitignore', getGitIgnore());
}

function getMakefile() {
  return dedent`
    build:
    	gcc -o main main.c
    format:
    	clang-format -i *.c
  `;
}

function getMainC() {
  return dedent`
    #include <stdio.h>

    int main(int argc, char *argv[]) {
      printf("hello world");
    }
  `;
}

function getGitIgnore() {
  return dedent`
    *
    !*/
    !*.*
    !Makefile
  `;
}
