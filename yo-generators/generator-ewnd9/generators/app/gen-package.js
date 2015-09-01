module.exports = function(packageName, deps, devDeps, scripts) {
  var result = {};

  result.name = packageName;
  result.version = '0.0.0';
  result.description = 'INSERT_DESCRIPTION';
  result.main = 'index.js';
  result.scripts = scripts || {
    test: 'echo \"Error: no test specified\" && exit 1'
  };
  result.preferGlobal = 'false',
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
