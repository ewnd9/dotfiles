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
      name: 'package_name',
      message: 'Insert package name',
      default: path.basename(process.cwd())
    }];

    this.prompt(prompts, function (props) {
      this.props = props;
      this.package_name = props.package_name;

      done();
    }.bind(this));
  },

  writing: {
    app: function () {
      this.template('_package.json', 'package.json');
      this.template('_readme.md', 'README.md');
    },

    projectfiles: function () {
      this.fs.copy(
        this.templatePath('editorconfig'),
        this.destinationPath('.editorconfig')
      );
      this.fs.copy(
        this.templatePath('gitignore'),
        this.destinationPath('.gitignore')
      );
      this.fs.copy(
        this.templatePath('travis.yml'),
        this.destinationPath('.travis.yml')
      );
    }
  },

  install: function () {
    // this.installDependencies();
  }
});
