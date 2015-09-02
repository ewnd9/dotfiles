var assign = require('object-assign');

module.exports.genPackage = function(base, pkgDeps, pkgDevDeps, pkgScripts) {
  assign(pkgDevDeps, {
    "babel": "^5.8.23",
    "babel-core": "^5.8.23",
    "babel-loader": "^5.3.2",
    "css-loader": "^0.16.0",
    "file-loader": "^0.8.4",
    "image-webpack-loader": "^1.6.1",
    "imagemin": "^3.2.0",
    "imports-loader": "^0.6.4",
    "node-sass": "^3.3.2",
    "sass-loader": "^2.0.1",
    "style-loader": "^0.12.3",
    "webpack": "^1.12.0",
    "webpack-dev-server": "^1.10.1"
  });
  assign(pkgScripts, {
    "start": "webpack-dev-server"
  });

  base.packageInstall = '$ npm install';
  base.packageUsage = '$ webpack-dev-server';
};
