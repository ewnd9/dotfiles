'use strict';

module.exports = {
  parser: 'babel-eslint',
  env: {
    node: true
  },
  globals: {
    Promise: true
  },
  rules: {
    'arrow-parens': [
      2,
      'as-needed'
    ],
    'no-const-assign': 2,
    'no-undef': 2,
    'no-unused-vars': 2,
    'object-shorthand': 2,
    'prefer-const': [2, {
      'destructuring': 'all',
      'ignoreReadBeforeAssign': false
    }]
  }
};
