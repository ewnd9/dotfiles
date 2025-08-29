import path from 'path';

const argv = require('minimist')(process.argv.slice(2), { string: '_' });

if (argv._[0] === 'list') {
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

function getCommands() {
  const pkgPath = require.resolve('./package.json');
  const pkgDir = path.dirname(pkgPath);
  const pkg = require(pkgPath);
  return Object.entries(pkg.belt.commands).reduce((commands, [name, info]) => {
    const scriptPath = `${pkgDir}/${info.script}`;
    commands[name] = {
      name,
      pkg,
      pkgName: pkg.name,
      pkgPath,
      scriptPath,
      description: info.description || '<no-description>'
    };

    return commands;
  }, {});
}
