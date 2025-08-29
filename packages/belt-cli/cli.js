#!/usr/bin/env node

'use strict';

const path = require('path');
const fs = require('fs');
const chalk = require('chalk');
const Configstore = require('configstore');

// ~/.config/configstore/belt-cli.json
const confMain = new Configstore('belt-cli', { modules: [] });
// ~/.config/configstore/belt-cli-config.json
const confData = new Configstore('belt-cli-config');

const argv = require('minimist')(process.argv.slice(2), { string: '_' });

if (argv._[0] === 'install') {
  install({ name: argv._[1] });
} else if (argv._[0] === 'link') {
  link({ modulePath: argv._[1] });
} else if (argv._[0] === 'list') {
  printHelp();
} else if (argv._.length > 0) {
  run({ argv });
} else {
  printHelp();
}

async function run({ argv }) {
  const commands = getCommands();
  const command = commands[argv._[0]];

  if (!command) {
    throw new Error(`unknown command "${argv._[0]}"`);
  }

  argv._.splice(0, 1);

  const ctx = {
    argv,
    command,
    async ensureConfig(cmdKey, params) {
      const prompts = require('prompts');
      const result = {};

      for (const [k, v] of Object.entries(params)) {
        const key = `${cmdKey}.${k}`;
        const ret  = confData.get(key);

        if (ret !== undefined) {
          result[k] = ret;
          continue;
        }

        const response = await prompts({
          type: v.type || 'text',
          name: 'value',
          message: v.description || k
        });

        result[k] = response.value;
        confData.set(key, response.value);
      }

      return result;
    }
  };

  const mod = require(command.scriptPath);
  await mod.run(ctx);
}

function printHelp() {
  const groupBy = require('lodash.groupby');
  const sortBy = require('lodash.sortby');
  const commands = getCommands();

  const groups = Object.entries(groupBy(Object.entries(commands), ([command]) => {
    const parts = command.split(':');
    return parts.length === 1 ? '_' : parts[0];
  }));

  const noPrefix = groups.find(_ => _[0] === '_') || ['_', []];
  const prefixed = sortBy(groups.filter(_ => _[0] !== '_'), '[0]');

  console.log(`\nmain config: ${confMain.path}\ndata config: ${confData.path}\n`);

  sortBy(noPrefix[1], '[0]').forEach(([command, info]) => {
    console.log(`- ${command} (${info.description})`);
  });

  let prevLength = noPrefix[1].length;

  prefixed.forEach(([, commands]) => {
    if (prevLength > 1) {
      console.log();
    }

    sortBy(commands, '[0]').forEach(([command, info]) => {
      console.log(`- ${command} (${info.description})`);
    });

    prevLength = commands.length;
  });
}

async function install({ name }) {
  const envPaths = require('env-paths');
  const makeDir = require('make-dir');
  const npm = require('global-npm');
  const { promisify: pify } = require('util');

  const paths = envPaths('belt-cli');
  const modulesDir = `${paths.data}/dependencies`;

  if (!fs.existsSync(modulesDir)) {
    makeDir.sync(modulesDir);
    fs.writeFileSync(`${modulesDir}/package.json`, JSON.stringify({
      name: 'belt-dependencies',
      private: true,
      description: 'programmatically installed dependencies (github.com/ewnd9/belt)'
    }, null, 2));
  }

  await pify(npm.load)();
  const installer = new npm.commands.install.Installer(modulesDir, false, [name]);
  await installer.run();

  installer.args.forEach(({ name }) => {
    const pkgPath = `${modulesDir}/node_modules/${name}/package.json`;
    appendToRegistry(pkgPath);
  });
}

function link({ modulePath }) {
  const absolutePath = path.resolve(modulePath);
  const pkgPath = `${absolutePath}/package.json`;
  appendToRegistry(pkgPath);
}

function appendToRegistry(pkgPath) {
  if (!fs.existsSync(pkgPath)) {
    console.error(`${pkgPath} doesn't exist`);
    process.exit(1);
  }

  const pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf-8'));
  if (!pkg.belt || !pkg.belt.commands) {
    console.error(chalk.red(`"belt.commands" is missing in ${pkgPath}`));
    process.exit(1);
  }

  const modules = confMain.get('modules');

  if (modules.indexOf(pkgPath) > -1) {
    console.warn(chalk.grey(`"${pkgPath}" is already in registry`));
  } else {
    confMain.set('modules', modules.concat(pkgPath));
  }
}

function getCommands() {
  const commands = {};

  for (const pkgPath of confMain.get('modules')) {
    const pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf-8'));

    Object.entries(pkg.belt.commands).map(([name, info]) => {
      const scriptPath = `${path.dirname(pkgPath)}/${info.script}`;
      commands[name] = {
        name,
        pkg,
        pkgName: pkg.name,
        pkgPath,
        scriptPath,
        description: info.description || '<no-description>'
      }
    });
  }

  return commands;
}
