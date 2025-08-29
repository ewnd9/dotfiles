'use strict';

const fs = require('fs');
const path = require('path');
const mkdirp = require('mkdirp');
const CSON = require('season');
const yaml = require('js-yaml');
const invert = require('lodash/fp/invert');

const rootPath = path.resolve(`${__dirname}/../../../..`);

const atomGrammars = {
  '.source.shell': 'bash',
  '.source.css': 'css',
  '.text.html': 'html',
  '.source.js': 'javascript',
  '.source.json': 'json',
  '.source.gfm': 'markdown'
};

const atomGrammarsByLang = invert(atomGrammars);

module.exports = {
  rootPath,
  transformAtom,
  generateAtom,
  generateCode
};

function transformAtom(lang, srcPath, destPath) {
  mkdirp.sync(path.dirname(destPath));

  const content = CSON.readFileSync(srcPath);
  const snippets = Object.entries(content).reduce((total, [, snippets]) => {
    Object.entries(snippets).forEach(([name, snippet]) => {
      total.push({ name, prefix: snippet.prefix, body: snippet.body });
    });

    return total;
  }, []);

  const result = {
    lang,
    snippets
  };

  fs.writeFileSync(destPath, yaml.safeDump(result, { lineWidth: 120 }));
  return result;
}

function generateAtom(lang, snippets, paths) {
  const result = {
    [atomGrammarsByLang[lang]]: snippets.reduce((total, { name, prefix, body }) => {
      total[name] = {
        prefix,
        body
      };

      return total;
    }, {})
  };

  paths.forEach(path => {
    const content = CSON.stringify(result)
      .replace(/\n\s+\n/g, '\n\n')

    fs.writeFileSync(path, content);
  });
}

function generateCode(lang, snippets, paths) {
  const result = snippets.reduce((total, { name, prefix, body }) => {
    total[name] = {
      prefix,
      // vs-code needs to encode ${string} to $\\{string\\}
      // see https://github.com/Microsoft/vscode/issues/1670
      // body: body.replace(/\\([\{\}])/gm, '$1'),
      body: body.replace(/\$\{([_a-zA-Z]+)\}/gm, '\${$1\\}'),
      description: name
    };

    return total;
  }, {});

  paths.forEach(path => {
    fs.writeFileSync(path, JSON.stringify(result, null, 2));
  });
}
