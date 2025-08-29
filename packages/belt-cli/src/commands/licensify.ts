

import fs from 'fs';
import path from 'path';

export async function run() {
  const pkgPath = './package.json';
  const json = JSON.parse(fs.readFileSync(pkgPath, 'utf-8'));

  // @TODO: ensure order
  Object.assign(json, {
    repository: {
      type: 'git',
      url: `git+https://github.com/ewnd9/${path.basename(process.cwd())}.git`
    },
    author: 'ewnd9 <ewndnine@gmail.com>',
    license: 'MIT'
  });

  fs.writeFileSync(pkgPath, JSON.stringify(json, null, 2));

  fs.appendFileSync('./README.md', [
    '## License',
    '',
    'MIT © [ewnd9](http://ewnd9.com)',
    ''
  ].join('\n'));
}


