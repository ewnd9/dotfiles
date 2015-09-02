var assign = require('object-assign');

module.exports.genPackage = function(base, pkgDeps, pkgDevDeps, pkgScripts, misc) {
  assign(pkgDeps, {
    "babel": "^5.8.21"
  });
  assign(pkgDevDeps, {
    "chai": "^3.2.0",
    "mocha": "^2.2.5"
  });
  assign(pkgScripts, {
    "start": "node cli.js",
    "test": "mocha --require babel/register",
  });

  base.packageInstall = '$ npm install';
  base.packageUsage = '$ npm start';

  misc.bin = 'cli.js';
  misc.preferGlobal = 'true';
  misc.main = 'lib/index.js';
};
