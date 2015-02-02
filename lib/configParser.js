const C      = require("../lib/constants")
const config = require(C.PATHS.CONFIG)

module.exports = class ConfigParser {
  constructor(_config) {
    this.config = this._sanitize(_config || config)
  }

  _sanitize(config = {}) {
    if(!config.global){
      config.global = {}
    }
    if(!config.commands){
      config.commands = {}
    }
    if(!config.commands.quiz){
      config.commands.quiz = {}
    }
    return config
  }

  toOptions() {
    let options = {path: {}, flags: {}}
    if(this.config.global.hasOwnProperty('defaultCommand')){
      options.command = this.config.global.defaultCommand
    }
    if(this.config.global.hasOwnProperty('questionsPath')){
      options.path.questions = this.config.global.questionsPath
    }
    if(this.config.global.hasOwnProperty('completedPath')){
      options.path.completed = this.config.global.completedPath
    }
    if(this.config.commands.quiz.hasOwnProperty('affirmations')){
      options.affirmations = this.config.commands.quiz.affirmations
    }
    if(this.config.commands.quiz.hasOwnProperty('stern')){
      options.flags.stern = this.config.commands.quiz.stern
    }
    if(this.config.commands.quiz.hasOwnProperty('shuffle')){
      options.flags.shuffle = this.config.commands.quiz.shuffle
    }
    if(this.config.commands.quiz.hasOwnProperty('numberOfQuestions')){
      options.flags.numberOfQuestions = this.config.commands.quiz.numberOfQuestions
    }
    if(this.config.commands.quiz.hasOwnProperty('all')){
      options.flags.all = this.config.commands.quiz.all
    }
    return options
  }
}
