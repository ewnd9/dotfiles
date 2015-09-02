module.exports = function(packageName, deps, devDeps, scripts, misc) {
  var result = {};

  result.name = packageName;
  result.version = '0.0.0';
  result.description = 'INSERT_DESCRIPTION';
  result.main = misc.main || 'index.js';
  result.bin = misc.bin || void 0;
  result.scripts = scripts || {
    test: 'echo \"Error: no test specified\" && exit 1'
  };
  result.preferGlobal = misc.preferGlobal || 'false',
  result.repository = {
    type: 'git',
    url: 'git+https://github.com/ewnd9/' + packageName + '.git'
  };
  result.keywords = [
    'INSERT_KEYWORDS'
  ];
  result.author = 'ewnd9 <ewndnine@gmail.com>';
  result.license = 'MIT';

  result.dependencies = deps || {};
  result.devDependencies = devDeps || {};

  return result;
};
