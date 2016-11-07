'use strict';

const { parse, visitor } = require('./visitor');
const fs = require('fs');

const filename = process.env.HOME + '/dotfiles/config/awesome/keybindings.lua';
const code = fs.readFileSync(filename, 'utf-8');

find(code);

function find(code) {
  const ast = parse(code);
  const result = [];

  visitor(ast, {
    type: 'CallExpression',
    base: {
      type: 'MemberExpression',
      base: {
        name: 'awful',
        type: 'Identifier'
      },
      identifier: {
        name: 'key',
        type: 'Identifier'
      }
    }
  }, node => {
    result.push(node.arguments.map(format));

    // console.log(node.arguments)
    function format(arg) {
      if (arg.type === 'StringLiteral') {
        return arg.raw;
      } else if (arg.type === 'TableConstructorExpression') {
        return arg.fields.map(format).join(' + ');
      } else if (arg.type === 'TableValue') {
        return format(arg.value);
      } else if (arg.type === 'Identifier') {
        return arg.name;
      } else if (arg.type === 'StringLiteral') {
        return arg.value;
      } else if (arg.type === 'MemberExpression') {
        return format(arg.base) + '.' + format(arg.identifier);
      } else if (arg.type === 'FunctionDeclaration') {
        return 'function () ' + arg.body.map(format).join('\n') + ' end';
      } else if (arg.type === 'IfStatement') {
        return arg.clauses.map(format).join(' ');
      } else if (arg.type === 'IfClause') {
        return 'if ' + format(arg.condition) + ' then ' + arg.body.map(format).join('\n') + ' end';
      } else if (arg.type === 'CallStatement') {
        return format(arg.expression);
      } else if (arg.type === 'CallExpression') {
        return format(arg.base) + '(' + arg.arguments.map(format).join(', ') + ')';
      } else if (arg.type === 'NumericLiteral') {
        return arg.value;
      } else if (arg.type === 'UnaryExpression') {
        return arg.operator;
      } else if (arg.type === 'IndexExpression') {
        return format(arg.base) + '[' + format(arg.index) + ']';
      } else if (arg.type === 'BinaryExpression') {
        return format(arg.left) + ' ' + arg.operator + ' ' + format(arg.right);
      } else if (arg.type === 'LogicalExpression') {
        return format(arg.left) + ' ' + arg.operator + ' ' + format(arg.right);
      } else if (arg.type === 'LocalStatement') {
        return arg.init.map((init, i) => `local ${format(arg.variables[i])} = ${format(init)}`);
      } else if (arg.type === 'AssignmentStatement') {
        return arg.init.map((init, i) => `${format(arg.variables[i])} = ${format(init)}`);
      } else if (arg.type === 'BooleanLiteral') {
        return arg.value;
      } else {
        console.log('unknown', arg)
        return '<<UNPARSED>>';
      }
      //            if client.focus then client.focus:raise() end

    }
  });

  fs.writeFileSync(__dirname + '/result.json', JSON.stringify(result, null, 2));
}
