

import fs from 'fs';
import yaml from 'js-yaml';
import { globby } from 'globby';
import { rootPath, generateCode } from "./utils.js";

export async function run() {
  const snippetsPath = `${rootPath}/snippets`;
  const files = await globby(['**/*.yaml'], { cwd: snippetsPath, absolute: true });
  const snippets = files.reduce((total: any, file: string) => {
    const content = yaml.load(fs.readFileSync(file, 'utf8')) as any;

    if (!total[content.lang]) {
      total[content.lang] = [];
    }

    total[content.lang].push.apply(total[content.lang], content.snippets);
    return total;
  }, {});

  const paths = {
    bash: {
      code: `${rootPath}/config/code/snippets/shellscript.json`,
    },
    css: {
      code: `${rootPath}/config/code/snippets/css.json`,
    },
    html: {
      code: `${rootPath}/config/code/snippets/html.json`,
    },
    javascript: {
      code: [
        `${rootPath}/config/code/snippets/javascript.json`,
        `${rootPath}/config/code/snippets/javascriptreact.json`,
        `${rootPath}/config/code/snippets/typescript.json`,
        `${rootPath}/config/code/snippets/typescriptreact.json`
      ]
    },
    json: {
      code: `${rootPath}/config/code/snippets/json.json`
    },
    jsonc: {
      code: `${rootPath}/config/code/snippets/jsonc.json`
    },
    markdown: {
      code: [
        `${rootPath}/config/code/snippets/markdown.json`
      ]
    }
  };

  Object.entries(snippets).forEach(([lang, snippets]: [string, any]) => {
    generateCode(
      lang,
      snippets,
      arrayify((paths as any)[lang].code)
    );
  });
}

function arrayify(xs: any) {
  return Array.isArray(xs) ? xs : [xs];
}
