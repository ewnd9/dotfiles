var assign = require('object-assign');

module.exports.genPackage = function(base, pkgDeps, pkgDevDeps, pkgScripts) {
  assign(pkgDeps, {
    "babel": "^5.8.21",
    "express": "^4.13.3",
    "express-cors": "0.0.3",
    "lodash": "^3.10.1",
    "moment": "^2.10.6",
    "morgan": "^1.6.1"
  });
  assign(pkgDevDeps, {
    "nodemon": "^1.4.1"
  });
  assign(pkgScripts, {
    "start": "nodemon app.js"
  });

  base.packageInstall = '$ npm install';
  base.packageUsage = '$ npm start';
};
