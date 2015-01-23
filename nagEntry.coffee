fs          = require("fs")
Stream      = require("stream")
Questions   = require("./lib/questions")

module.exports = class Nag
  constructor: (opt = {}) ->
    if opt.interactive
      @cli()

  @parser: require("path")
  cli: () ->
    NagReadline = require("./lib/nagReadline")
    Questions.load
      onReady: (questions) ->
        process.exit(0) unless questions.currentQuestion()

        nextQuestion = () ->
          questions.nextQuestion()
          process.exit(0) unless questions.currentQuestion()
          readline.question(
            question: questions.currentQuestionToS()
            onAnswer: onAnswer
          )

        onAnswer = (answer) ->
          questions.logCurrent() if answer == 'yes'
          nextQuestion()

        readline  = new NagReadline()

        readline.question(
          question: questions.currentQuestionToS()
          onAnswer: onAnswer
        )
