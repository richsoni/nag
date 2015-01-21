io = require("./nagIO")

class Questions
  constructor: () ->
    @questions = io.loadQuestions()
    @_currentQuestion = 0

  currentQuestion: () -> @questions[@_currentQuestion]?.question
  nextQuestion: () -> @_currentQuestion = @_currentQuestion + 1

module.exports = new Questions()
