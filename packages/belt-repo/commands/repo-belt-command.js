'use strict';

const fs = require('fs');
const path = require('path');
const dedent = require('dedent');

module.exports = {
  run
};

async function run({ argv }) {
  if (argv._.length !== 2) {
    throw new Error(`Usage: $ belt repo:belt-command <namespace>:<name> '<description>'`);
  }

  const [fullCommandName, description] = argv._;
  const [/*namespace*/, name] = fullCommandName.split(':');

  const pkgPath = path.resolve(`${process.cwd()}/package.json`);
  const pkg = require(pkgPath);

  if (!pkg.belt && !argv.force) {
    throw new Error(`"${pkgPath}" doesn't contain "belt" property. Use --force to proceed`);
  }

  pkg.belt = pkg.belt || {};
  pkg.belt.commands = pkg.belt.commands || {};
  pkg.belt.commands[fullCommandName] = {
    script: `commands/${name}`,
    description
  };

  fs.writeFileSync(pkgPath, JSON.stringify(pkg, null, 2));
  fs.writeFileSync(`commands/${name}.js`, dedent`
    'use strict';

    const execa = require('@belt/tools/modules/execa');

    module.exports = {
      run
    };

    async function run({ argv }) {
    }
  `);
}

