import fs from 'fs';
import path from 'path';

export const rootPath = path.resolve(`${__dirname}/../../../..`);

export function generateCode(lang: string, snippets: any[], paths: string[]) {
  const result = snippets.reduce((total: any, { name, prefix, body }: any) => {
    total[name] = {
      prefix,
      // vs-code needs to encode ${string} to $\\{string\\}
      // see https://github.com/Microsoft/vscode/issues/1670
      // body: body.replace(/\\([\{\}])/gm, '$1'),
      body: body.replace(/\$\{([_a-zA-Z]+)\}/gm, '${$1\\}'),
      description: name,
    };

    return total;
  }, {} as any);

  paths.forEach((pathItem: string) => {
    fs.writeFileSync(pathItem, JSON.stringify(result, null, 2));
  });
}
