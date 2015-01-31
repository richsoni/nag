C      = require("../lib/constants")
config = require(C.PATHS.CONFIG)

module.exports = class ConfigParser
  constructor: (_config) ->
    @config = @_sanitize(_config || config)


  _sanitize: (config = {}) ->
    config.global = {} unless config.global
    config.commands = {} unless config.commands
    config.commands.quiz = {} unless config.commands.quiz
    return config

  toOptions: () ->
    options = {path: {}, flags: {}}
    options.command = @config.global.defaultCommand if @config.global.hasOwnProperty('defaultCommand')
    options.path.questions = @config.global.questionsPath if @config.global.hasOwnProperty('questionsPath')
    options.path.completed = @config.global.completedPath if @config.global.hasOwnProperty('completedPath')
    options.affirmations   = @config.commands.quiz.affirmations if @config.commands.quiz.hasOwnProperty('affirmations')
    options.flags.stern    = @config.commands.quiz.stern if @config.commands.quiz.hasOwnProperty('stern')
    options.flags.shuffle    = @config.commands.quiz.shuffle if @config.commands.quiz.hasOwnProperty('shuffle')
    options.flags.numberOfQuestions    = @config.commands.quiz.numberOfQuestions if @config.commands.quiz.hasOwnProperty('numberOfQuestions')
    options.flags.all    = @config.commands.quiz.all if @config.commands.quiz.hasOwnProperty('all')
    return options
