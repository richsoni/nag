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
