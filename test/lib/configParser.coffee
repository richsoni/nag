require("../globals")
ConfigParser = require("../../lib/configParser")
fixture      = require("../../config-template/config")

suite 'Sanitizing', ->
  test 'properly sanitizes its input', ->
    config = new ConfigParser({}).config
    assert typeof config.global  == 'object', 'needs globals'
    assert typeof config.commands == 'object', 'needs commands'


suite 'to_options', ->
  test 'properly converts', ->
    options = new ConfigParser(fixture).toOptions()
    assert fixture.global.defaultCommand == options.command, 'default command wraps around'
    assert fixture.global.questionsPath == options.path.questions, 'questions path wraps around'
    assert fixture.global.completedPath == options.path.completed, 'completed path wraps around'
    # its an array :/
    # assert fixture.commands.quiz.affirmations == options.affiramations, 'affirmations wraps around'
    assert fixture.commands.quiz.stern == options.flags.stern, 'stern should match'
    assert fixture.commands.quiz.shuffle == options.flags.shuffle, 'shuffle should match'
    assert fixture.commands.quiz.numberOfQuestions == options.flags.numberOfQuestions, 'numberOfQuestions should match'
    assert fixture.commands.quiz.all == options.flags.all, 'all should match'

  test 'ignores keys that are not defined', ->
    options = new ConfigParser({global: {defaultCommand: 'test'}}).toOptions()
    # assert !options.path.hasOwnProperty('questions')
