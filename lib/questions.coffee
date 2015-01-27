io           = require("./nagIO")
moment       = require("moment")
shuffleArray = require("shuffle-array")
NOW          = moment()

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
    {onReady, shuffle, number, all} = args
    io.loadHistory
      onEnd: (history) ->
        onReady(new Questions({history, opts:{shuffle, number, all}}))

  constructor: (args) ->
    {@history, @opts} = args
    @_loadQuestions()
    @relevantQuestions = @_selectQuestionList()

  _loadQuestions: () ->
    questions = io.loadQuestions().map (q) => new Question(question: q.question, filters: q.filters, lastOccurance: @history[q.question])
    @_questions = questions.reduce ((memo, question) =>
      if question.isRelevant()
        memo.concat question
      else
        memo
    ), []

  _selectQuestionList: () ->
    @_currentQuestion = 0
    questions = @_questions
    questions = shuffleArray(@_questions, copy:true) if @opts.shuffle
    questions = questions.slice(0,@opts.number) if @opts.number && !@opts.all
    return questions


  currentQuestion: () -> @relevantQuestions[@_currentQuestion]?.question
  nextQuestion: () ->
    @_currentQuestion = @_currentQuestion + 1
  currentQuestionToS: () -> "> did you #{@currentQuestion()} today? "
  logCurrent: () ->
    timestamp = moment().format('YYYY-MM-DD')
    io.logData("#{timestamp} #{@currentQuestion()}\n")
