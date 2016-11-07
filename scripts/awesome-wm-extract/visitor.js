'use strict';

const parser = require('luaparse');
const isEqual = require('lodash.isequal');

exports.parse = parse;
exports.visitor = visitor;

function parse(code) {
  return parser.parse(code);
}

function visitor(root, properties, callback) {
  if (root !== null && typeof root === 'object') {
    if (isPartiallyEqual(root, properties)) {
      callback(root);
    }
  }

  if (Array.isArray(root)) {
    for (const node of root) {
      visitor(node, properties, callback);
    }
  } else if (typeof root === 'object') {
    for (const node in root) {
      visitor(root[node], properties, callback);
    }
  }
}

function isPartiallyEqual(actual, expected) {
  return Object.keys(expected).every(key => {
    const actualValue = actual[key];
    const expectedValue = expected[key];
    // console.log(expectedValue, actualValue)

    if (expectedValue !== null && typeof expectedValue === 'object') {
      return isPartiallyEqual(actualValue, expectedValue);
    } else {
      return expectedValue === actualValue;
    }
  });
}
