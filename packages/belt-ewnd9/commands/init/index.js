'use strict';

const fs = require('fs');
const execa = require('execa');
const makeDir = require('make-dir');
const gitUrlParse = require('git-url-parse');
const qs = require('qs');
const ncp = require('ncp');
const kebabCase = require('lodash/kebabCase');
const snakeCase = require('lodash/snakeCase');
const camelCase = require('lodash/camelCase');
const upperFirst = require('lodash/camelCase');
const upperCase = require('lodash/upperCase');

module.exports = {
  run
};

async function run({ argv }) {
  const parts = getParts(argv);
  const repoDir = `${process.env.HOME}/.cache/belt-ewnd9-init/${[
    parts.source,
    parts.full_name
  ]
    .join('-')
    .replace(/\W+/g, '-')}`;

  const name = argv.name || parts.templatePath.split('/').pop();

  if (!fs.existsSync(repoDir)) {
    await makeDir(repoDir);
    await execa('git', ['clone', parts.repoUrl.split('#')[0], repoDir], {
      stdio: 'inherit'
    });
  } else {
    await execa('git', ['checkout', parts.branch], { cwd: repoDir });
  }

  if (argv.sync) {
    await execa('git', ['pull', 'origin', parts.branch], { cwd: repoDir });
  }

  const fullTemplatePath = `${repoDir}/${parts.templatePath}`;
  const ignore = ['.gitignore', 'yarn.lock'];

  if (!fs.existsSync(fullTemplatePath)) {
    throw new Error(`"${fullTemplatePath}" doesn't exist`);
  }

  await new Promise((resolve, reject) => {
    ncp(
      fullTemplatePath,
      process.cwd(),
      {
        transform(read, write) {
          if (ignore.some(ignoredFile => read.path.endsWith(ignoredFile))) {
            read.pipe(write);
            return;
          }

          fs.readFile(read.path, 'utf8', (err, data) => {
            if (err) {
              throw err;
            }

            const result = data
              .replace(new RegExp('generator-template', 'g'), kebabCase(name))
              .replace(new RegExp('generator_template', 'g'), snakeCase(name))
              .replace(new RegExp('generatorTemplate', 'g'), camelCase(name))
              .replace(
                new RegExp('GeneratorTemplate', 'g'),
                upperFirst(camelCase(name))
              )
              .replace(
                new RegExp('GENERATOR_TEMPLATE', 'g'),
                upperCase(snakeCase(name))
              );

            fs.writeFile(write.path, result, 'utf8', err => {
              if (err) {
                throw err;
              }

              return null;
            });
          });
        }
      },
      err => {
        if (err) {
          reject(err);
        } else {
          resolve();
        }
      }
    );
  });
}

function getParts({from: repoUrl, template: templatePath}) {
  if (repoUrl) {
    const parts = gitUrlParse(repoUrl);
    const [branch, templateOpts] = parts.hash.split('?');
    const { path: templatePath } = qs.parse(templateOpts);

    return {
      ...parts,
      repoUrl,
      branch,
      templatePath,
    };
  } else {
    const repoUrl = 'https://github.com/ewnd9/templates.git#master?path=node-express';
    const parts = gitUrlParse(repoUrl);

    return {
      ...parts,
      repoUrl,
      branch: 'master',
      templatePath: templatePath || 'node',
    };
  }
}
