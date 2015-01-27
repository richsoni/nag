require("../globals")
Questions = require("../../lib/questions")

suite 'Setup', ->
  test 'load', (done) ->
    Questions.load
      onReady: (questions) ->
        assert(questions._currentQuestion == 0)
        done()

  test 'shuffle', (done) ->
    #TODO requires questions (there should be a fixture for this
    Questions.load
      shuffle: true
      onReady: (questions) ->
        shuffled = JSON.stringify(questions.relevantQuestions)
        questions.shuffle = false
        nonShuffled = JSON.stringify(questions._selectQuestionList())
        assert(shuffled != nonShuffled, 'shuffle should change order of questions')
        done()

  test '1 number', (done) ->
    #TODO requires questions (there should be a fixture for this
    Questions.load
      number:  1
      onReady: (questions) ->
        assert(questions.relevantQuestions.length == 1, 'control number of questions asked')
        done()

  test '3 number', (done) ->
    #TODO requires questions (there should be a fixture for this
    Questions.load
      number:  3
      onReady: (questions) ->
        assert(questions.relevantQuestions.length == 3, 'control number of questions asked')
        done()

  test 'all', (done) ->
    #TODO requires questions (there should be a fixture for this
    Questions.load
      number:  1
      all: true
      onReady: (questions) ->
        assert(questions.relevantQuestions.length > 1, 'all will override number')
        done()
