io      = require("./nagIO")
history = io.history()
moment  = require("moment")
NOW     = moment()

class Filter
  constructor: (filters) ->
    @filters = filters || {}


  inRange: (timestamp) ->
    if @filters.between
      #supports only am and pm now
      FORMATS = ['hh:mma', 'hha']
      start = moment(@filters.between[0], FORMATS)
      end   = moment(@filters.between[1], FORMATS)
      start <= NOW <= end

class Question
  constructor: (q) ->
    {@question} = q
    @filter = new Filter(q.filters)

  isRelevant: () ->
    for item in history
      if item[1] == @question
        return false unless @filter.inRange(item[0])
    return true

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
