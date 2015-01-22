io      = require("./nagIO")
moment  = require("moment")
NOW     = moment()

class Filter
  constructor: (filters) ->
    @filters = filters || {}

  inRange: (timestamp) ->
    return false unless @testBetween()
    return true  unless @testOccuredToday(timestamp)

  testBetween: () ->
    if @filters.between
      #supports only am and pm now
      FORMATS = ['hh:mma', 'hha']
      start = moment(@filters.between[0], FORMATS)
      end   = moment(@filters.between[1], FORMATS)
      start <= NOW <= end
    else
      true

  testOccuredToday: (timestamp) ->
    timestamp &&
    ( NOW.day()   == timestamp.day() &&
    NOW.month() == timestamp.month() &&
    NOW.year()  == timestamp.year())

class Question
  constructor: (args) ->
    {@question, filters, @lastOccurance} = args
    @filter = new Filter(filters)

  isRelevant: () ->
    @filter.inRange(@lastOccurance)

module.exports = class Questions
  @load: (args) ->
    {onReady} = args
    io.loadHistory
      onEnd: (history) ->
        onReady(new Questions({history}))

  constructor: (args) ->
    {history} = args
    @history           = history
    @relevantQuestions = @_retrieveRelevantQuestionList()
    @_currentQuestion  = 0

  _retrieveRelevantQuestionList: () ->
    @_questions = io.loadQuestions().map (q) => new Question(question: q.question, filters: q.filters, lastOccurance: @history[q.question])
    @_questions.reduce ((memo, question) =>
      if question.isRelevant()
        memo.concat question
      else
        memo
    ), []

  currentQuestion: () -> @relevantQuestions[@_currentQuestion]?.question
  nextQuestion: () -> @_currentQuestion = @_currentQuestion + 1
  currentQuestionToS: () -> "> did you #{@currentQuestion()} today? "
  logCurrent: () ->
    timestamp = moment().format('YYYY-MM-DD')
    io.logData("#{timestamp} #{@currentQuestion()}\n")
