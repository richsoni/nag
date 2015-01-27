fs          = require("fs")
Stream      = require("stream")
Questions   = require("./lib/questions")
ConfigBuilder = require("./lib/configBuilder")

module.exports = class Nag
  constructor: (params = {}) ->
    {interactive, @opts} = params
    @opts ||= ConfigBuilder.build()
    if interactive
      @cli()

  @parser: require("path")
  cli: () ->
    NagReadline = require("./lib/nagReadline")
    Questions.load
      shuffle: @opts.flags.shuffle
      number:  @opts.flags.numberOfQuestions
      all:     @opts.flags.all
      onReady: (questions) =>
        process.exit(0) unless questions.currentQuestion()

        nextQuestion = () ->
          questions.nextQuestion()
          process.exit(0) unless questions.currentQuestion()
          readline.question(
            question: questions.currentQuestionToS()
            onAnswer: onAnswer
          )

        onAnswer = (answer) =>
          questions.logCurrent() if answer == 'yes'
          nextQuestion()

        readline  = new NagReadline({stern: @opts.flags.stern})

        readline.question(
          question: questions.currentQuestionToS()
          onAnswer: onAnswer
        )
