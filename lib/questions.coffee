io = require("./nagIO")

class Question
  constructor: (q) ->
    {@question, @filter} = q

  isRelevant: () -> true

class Questions
  constructor: () ->
    @questions = @_retrieveRelevantQuestionList()
    @_currentQuestion = 0

  _retrieveRelevantQuestionList: () ->
    questions = io.loadQuestions().map (q) -> new Question(q)
    questions.reduce ((memo, question) =>
      if question.isRelevant()
        memo.concat question
      else
        memo
    ), []

  currentQuestion: () -> @questions[@_currentQuestion]?.question
  nextQuestion: () -> @_currentQuestion = @_currentQuestion + 1

module.exports = new Questions()
