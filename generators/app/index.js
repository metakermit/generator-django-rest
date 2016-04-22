'use strict';
var yeoman = require('yeoman-generator');
var chalk = require('chalk');
var yosay = require('yosay');

module.exports = yeoman.generators.Base.extend({
  constructor: function () {
    yeoman.Base.apply(this, arguments);
    this.argument('project_name', {type: String, required: false});
  },
  prompting: function () {
    var done = this.async();

    // Have Yeoman greet the user.
    this.log(yosay(
      'Mess with the best, ' + chalk.red('Django likes REST...') + ' Yeah...'
    ));

    var prompts = [];

    if (!this.project_name) {
      prompts.splice(0, 0, {
        type: 'input',
        name: 'project_name',
        message: 'What is the name of your project?',
        default: 'mysite'
        //store   : true // ? http://yeoman.io/authoring/user-interactions.html
      });
    }

    this.prompt(prompts, function (props) {
      this.props = props;
      // To access props later use this.props.someOption;
      if (!this.props.project_name) {
        this.props.project_name = this.project_name;
      }

      done();
    }.bind(this));
  },

  writing: {
    django: function() {
      // - first without the mysite module
      this.fs.copyTpl(
        // skip Gruntfile.js, since it uses <% templates, causing clashes
        this.templatePath('django/mysite/!(mysite){/**/*,*}'),
        //this.destinationPath('/whydoineedthis/'),
        this.destinationPath('./whydoineedthis/'),
        this.props
        //{interpolate: /{{([\s\S]+?)}}/g} // using the {{ }} template delim.
      );
      this.fs.copyTpl(
        this.templatePath('django/mysite/mysite/{/**/*,*}'),
        //this.destinationPath(this.props.project_name + '/whydoineedthis/'),
        this.destinationPath(this.props.project_name + '/whydoineedthis/'),
        this.props
        //{interpolate: /{{([\s\S]+?)}}/g} // using the {{ }} template delim.
      );
    },

    projectfiles: function () {
      this.fs.copyTpl(
        this.templatePath('*'),
        this.destinationPath('./whydoineedthis/'),
        this.props
        //{interpolate: /{{([\s\S]+?)}}/g} // using the {{ }} template delim.
      );
      // this.fs.copy(
      //   this.templatePath('editorconfig'),
      //   this.destinationPath('.editorconfig')
      // );
    }
  },

  install: function () {
    //this.installDependencies();
  }
});
