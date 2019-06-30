'use strict';

const path = require('path');
const {stringify} = require('dotenv-stringify');

module.exports = {
  run
};

async function run({ argv }) {
  const file = path.resolve(argv._[0]);
  const content = require(file);
  console.log(stringify({variable: content}));
}


