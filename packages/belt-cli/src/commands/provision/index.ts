

import fs from 'fs';
import path from 'path';
import yaml from 'js-yaml';

export async function run({ argv }: { argv: any }) {
  const rootPath = path.resolve(`${__dirname}/../../../..`);
  const configPath = `${rootPath}/provision/apt.yaml`; // @TODO split to separate configs

  const doc = yaml.load(fs.readFileSync(configPath, 'utf8')) as any;

  if (argv.extract) {
    const target = argv.extract;
    doc[target] = await require(`./tasks/${target}`).extract(doc[target]);

    fs.writeFileSync(configPath, yaml.dump(doc, { lineWidth: 80, skipInvalid: true }));
  } else if (argv.setup) {
    const target = argv.setup;
    await require(`./tasks/${target}`).setup(doc[target]);
  } else {
    console.log('use --extract <target> or --setup <target>');
  }
}

