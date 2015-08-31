'use strict';

var yeoman = require('yeoman-generator');
var chalk = require('chalk');
var yosay = require('yosay');
var path = require('path');

module.exports = yeoman.generators.Base.extend({
  prompting: function () {
    var done = this.async();

    // Have Yeoman greet the user.
    this.log(yosay(
      'Welcome to the top-notch ' + chalk.red('Ewnd9') + ' generator!'
    ));

    var prompts = [{
      type: 'input',
      name: 'packageName',
      message: 'Insert package name',
      default: path.basename(process.cwd())
    }, {
      type: 'list',
      name: 'type',
      message: 'Select Type',
      choices: [
        'default', 'webpack-dev-server'
      ]
    }];

    this.prompt(prompts, function (props) {
      this.props = props;
      this.packageName = props.packageName;
      this.projectType = props.type;

      done();
    }.bind(this));
  },

  writing: {
    app: function () {
      var pkgPath = this.destinationPath('package.json');
      var pkgDeps = {};
      var pkgDevDeps = {};

      if (this.projectType === 'webpack-dev-server') {
        pkgDevDeps = {
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
        };
      }

      var pkgData = require('./gen-package')(this.packageName, pkgDeps, pkgDevDeps);
      require('fs').writeFileSync(pkgPath, JSON.stringify(pkgData, null, 2), 'utf-8');

      this.packageUsage = 'INSERT_USAGE';
      this.template('_readme.md', 'README.md');
    },
    projectfiles: function () {
      var cp = function(tpl, dest) {
        this.fs.copy(this.templatePath(tpl), this.destinationPath(dest));
      }.bind(this);

      cp('editorconfig', '.editorconfig');
      cp('gitignore', '.gitignore');
      cp('travis.yml', '.travis.yml');

      if (this.projectType === 'webpack-dev-server') {
        cp('webpack-dev-server/webpack.config.js', 'webpack.config.js');
        cp('webpack-dev-server/app.js', 'src/js/app.js');
        cp('webpack-dev-server/style.scss', 'src/scss/style.scss');
        cp('webpack-dev-server/index.html', 'src/index.html');
      }
    }
  },

  install: function () {
    this.installDependencies();
  }
});
