import fs from 'node:fs';
import path, { dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import groupBy from 'lodash/groupBy.js';
import sortBy from 'lodash/sortBy.js';
import minimist from 'minimist';
import type { Ctx } from './interface.js';

const __dirname = dirname(fileURLToPath(import.meta.url));
const argv = minimist(process.argv.slice(2), { string: '_' });

if (argv._[0] === 'list') {
  printHelp();
} else if (argv._.length > 0) {
  run({ argv });
} else {
  printHelp();
}

async function run({ argv }: { argv: any }) {
  const commands = getCommands();
  const command = commands[argv._[0]];

  if (!command) {
    throw new Error(`unknown command "${argv._[0]}"`);
  }

  argv._.splice(0, 1);

  const ctx: Ctx = {
    argv,
    command,
  };

  const mod = await import(command.scriptPath);
  await mod.run(ctx);
}

function printHelp() {
  const commands = getCommands();

  const groups = Object.entries(
    groupBy(Object.entries(commands), ([command]: [string, any]) => {
      const parts = command.split(':');
      return parts.length === 1 ? '_' : parts[0];
    }),
  );

  const noPrefix = groups.find((_: [string, any]) => _[0] === '_') || ['_', []];
  const prefixed = sortBy(
    groups.filter((_: [string, any]) => _[0] !== '_'),
    '[0]',
  );

  sortBy(noPrefix[1], '[0]').forEach(([command, info]: [string, any]) => {
    console.log(`- ${command} (${info.description})`);
  });

  let prevLength = (noPrefix[1] as any[]).length;

  prefixed.forEach(([, commands]: [string, any[]]) => {
    if (prevLength > 1) {
      console.log();
    }

    sortBy(commands, '[0]').forEach(([command, info]: [string, any]) => {
      console.log(`- ${command} (${info.description})`);
    });

    prevLength = commands.length;
  });
}

function getCommands() {
  const pkgDir = path.resolve(`${__dirname}/..`);
  const pkgPath = path.resolve(`${pkgDir}/package.json`);
  const pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf-8'));
  return Object.entries((pkg.belt as any).commands).reduce((commands: any, [name, info]: [string, any]) => {
    const scriptPath = `${pkgDir}/dist/${(info as any).script}.js`;
    commands[name] = {
      name,
      pkg,
      pkgName: pkg.name,
      pkgPath,
      scriptPath,
      description: (info as any).description || '<no-description>',
    };

    return commands;
  }, {});
}
