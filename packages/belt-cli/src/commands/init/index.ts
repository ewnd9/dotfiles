import fs from 'fs';
import execa from "../../modules/execa.js";
import gitUrlParse from 'git-url-parse';
import qs from 'qs';
import ncp from 'ncp';
import prompts from 'prompts';
import kebabCase from 'lodash/kebabCase';
import snakeCase from 'lodash/snakeCase';
import camelCase from 'lodash/camelCase';
import upperFirst from 'lodash/camelCase';
import upperCase from 'lodash/upperCase';
import type { Ctx } from "../../interface.js";

export async function run({ argv }: Ctx) {
  const ctx = getContext(argv as any);

  if (argv.i || argv.interactive) {
    const dirs = fs.readdirSync(`${ctx.repoDir}/templates`);

    const overrides = await prompts([
      {
        type: 'text',
        name: 'name',
        message: 'name of a project',
      },
      {
        type: 'select',
        name: 'templatePath',
        message: 'pick a template',
        choices: dirs.map((dir) => ({ title: dir, value: `templates/${dir}` })),
        initial: 1,
      },
    ]);

    Object.assign(ctx, overrides);
  }

  if (!fs.existsSync(ctx.repoDir)) {
    fs.mkdirSync(ctx.repoDir, { recursive: true });
    await execa('git', ['clone', ctx.repoUrl.split('#')[0], ctx.repoDir], {
      stdio: 'inherit',
    });
  } else {
    await execa('git', ['checkout', ctx.branch], { cwd: ctx.repoDir });
  }

  if (argv.sync) {
    await execa('git', ['pull', 'origin', ctx.branch], { cwd: ctx.repoDir });
  }

  const fullTemplatePath = `${ctx.repoDir}/${ctx.templatePath}`;
  const ignore = ['.gitignore', 'yarn.lock'];

  if (!fs.existsSync(fullTemplatePath)) {
    throw new Error(`"${fullTemplatePath}" doesn't exist`);
  }

  await new Promise((resolve, reject) => {
    ncp(
      fullTemplatePath,
      process.cwd(),
      {
        transform(read: any, write: any) {
          if (ignore.some((ignoredFile) => read.path.endsWith(ignoredFile))) {
            read.pipe(write);
            return;
          }

          fs.readFile(read.path, 'utf8', (err, data) => {
            if (err) {
              throw err;
            }

            const result = data
              .replace(
                new RegExp('generator-template', 'g'),
                kebabCase(ctx.name)
              )
              .replace(
                new RegExp('generator_template', 'g'),
                snakeCase(ctx.name)
              )
              .replace(
                new RegExp('generatorTemplate', 'g'),
                camelCase(ctx.name)
              )
              .replace(
                new RegExp('GeneratorTemplate', 'g'),
                upperFirst(camelCase(ctx.name))
              )
              .replace(
                new RegExp('GENERATOR_TEMPLATE', 'g'),
                upperCase(snakeCase(ctx.name))
              );

            fs.writeFile(write.path, result, 'utf8', (err) => {
              if (err) {
                throw err;
              }

              return null;
            });
          });
        },
      },
      (err: Error) => {
        if (err) {
          reject(err);
        } else {
          resolve(true);
        }
      }
    );
  });
}

function getContext({
  name,
  from: repoUrl = 'https://github.com/ewnd9/templates.git?path=node-express&branch=master',
  template = 'node',
}: {
  name: string;
  from: string | undefined;
  template: string | undefined;
}) {
  const parseResult = gitUrlParse(repoUrl);
  const { branch = 'master', path: overridenTemplatePath } = qs.parse(
    parseResult.search
  );
  const templatePath = overridenTemplatePath || template;

  return {
    ...parseResult,
    repoUrl,
    branch,
    templatePath,
    repoDir: `${process.env.HOME}/.cache/belt-ewnd9-init/${[
      parseResult.source,
      parseResult.full_name,
    ]
      .join('-')
      .replace(/\W+/g, '-')}`,
    name: name || templatePath.split('/').pop(),
  };
}
