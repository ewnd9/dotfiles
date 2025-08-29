

import fs from 'fs';
import yaml from 'js-yaml';
import globby from 'globby';
import { rootPath, generateCode } from './utils';

const snippetsPath = `${rootPath}/snippets`;
const files = globby.sync(['**/*.yaml'], { cwd: snippetsPath, absolute: true  });

export default {
  run
};

async function run() {
  const snippets = files.reduce((total, file) => {
    const content = yaml.safeLoad(fs.readFileSync(file));

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

  Object.entries(snippets).forEach(([lang, snippets]) => {
    generateCode(
      lang,
      snippets,
      arrayify(paths[lang].code)
    );
  });
}

function arrayify(xs) {
  return Array.isArray(xs) ? xs : [xs];
}

// const js = transformAtom(
//   'javascript',
//   `${rootPath}/config/atom/snippets/js.cson`,
//   `${__dirname}/snippets/javascript/javascript.yaml`
// );
//
// transformAtom(
//   'bash',
//   `${rootPath}/config/atom/snippets/bash.cson`,
//   `${__dirname}/snippets/bash/bash.yaml`
// );
//
// transformAtom(
//   'css',
//   `${rootPath}/config/atom/snippets/css.cson`,
//   `${__dirname}/snippets/css/css.yaml`
// );
//
// transformAtom(
//   'html',
//   `${rootPath}/config/atom/snippets/html.cson`,
//   `${__dirname}/snippets/html/html.yaml`
// );
//
// transformAtom(
//   'markdown',
//   `${rootPath}/config/atom/snippets/md.cson`,
//   `${__dirname}/snippets/md/md.yaml`
// );
//
