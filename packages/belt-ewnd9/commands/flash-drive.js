'use strict';

const execa = require('belt-tools/modules/execa');
const prompts = require('prompts');

module.exports = {
  run
};

async function run() {
  const dir = '/media/flashdrive';
  const devices = await getDevices();
  const mounts = await getMounts();

  const { value } = await prompts({
    type: 'select',
    name: 'value',
    message: 'Pick a device',
    choices: devices.map(({ name, size }, i) => {
      const parts = [`${name} (${size})`];

      if (mounts[name] === dir) {
        parts.push('[already mounted]');
      }

      return {
        title: parts.join(' '),
        value: i
      };
    }),
    initial: devices.length - 1
  });

  const device = devices[value];

  if (!device) {
    return;
  }

  await execa('sudo', ['mkdir', '-p', dir], { stdio: 'inherit' });
  await execa('sudo', ['mount', device.name, dir], { stdio: 'inherit' });
  await execa('ls', ['-al'], { stdio: 'inherit', cwd: dir });
}

async function getDevices() {
  const stdout = await execa.stdout('sudo', ['fdisk', '-l'], { stdio: [0, 'pipe', 'pipe'] });
  const lines = stdout.split('\n');

  return lines
    .filter(_ => _.startsWith('/dev/sd'))
    .map(line => {
      const parts = line.split(/\s+/);

      const name = parts[0];
      const size = parts[4];

      return { name, size };
    });
}

async function getMounts() {
  const stdout = await execa.stdout('cat', ['/proc/mounts']);
  return stdout
    .split('\n')
    .reduce((acc, line) => {
      const [src, dest] = line.split(' ');

      if (src.startsWith('/dev/sd')) {
        acc[src] = dest;
      }

      return acc;
    }, {})
}

