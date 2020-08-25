'use strict';

const fs = require('fs');

module.exports = {
  run,
};

async function run() {
  generateKarabiner();
}

function generateKarabiner() {
  const config = JSON.parse(
    fs.readFileSync('config/karabiner/karabiner.json'),
    'utf-8'
  );
  const lines = [`## karabiner`, ``];

  for (const category of config.profiles[0].complex_modifications.rules) {
    lines.push(`- ${category.description}`);
    for (const rule of category.manipulators) {
      lines.push(`  - ${rule.description}`);
    }
  }

  fs.writeFileSync('config/karabiner/README.md', lines.join('\n'));
}
