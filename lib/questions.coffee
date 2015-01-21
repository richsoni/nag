io = require("./nagIO")

class Question
  constructor: (q) ->
    {@question, @filter} = q

class Questions
  constructor: () ->
    @_retrieveRelevantQuestionList()
    @_currentQuestion = 0

  _retrieveRelevantQuestionList: () ->
    @questions = io.loadQuestions().map (q) -> new Question(q)
    # questions = questions.reduce ((memo, item) =>
    #   if @_isRelevant(question)
    # ), []

  currentQuestion: () -> @questions[@_currentQuestion]?.question
  nextQuestion: () -> @_currentQuestion = @_currentQuestion + 1

module.exports = new Questions()
