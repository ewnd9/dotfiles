'use strict';

const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

module.exports = {
  run
};

async function run({ argv }) {
  const rootPath = path.resolve(`${__dirname}/../../../..`);
  const configPath = `${rootPath}/provision/apt.yaml`; // @TODO split to separate configs

  const doc = yaml.safeLoad(fs.readFileSync(configPath, 'utf8'));

  if (argv.extract) {
    const target = argv.extract;
    doc[target] = await require(`./tasks/${target}`).extract(doc[target]);

    fs.writeFileSync(configPath, yaml.safeDump(doc, { lineWidth: 80, skipInvalid: true }));
  } else if (argv.setup) {
    const target = argv.setup;
    await require(`./tasks/${target}`).setup(doc[target]);
  } else {
    console.log('use --extract <target> or --setup <target>');
  }
}

