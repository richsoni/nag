require("../globals")
const Questions = require("../../lib/questions")
const questions = [
  'plain',
  {'compound': ['10am', '11:59am']},
  'plain1',
  'plain2',
  'plain3',
  'plain4',
  {'doubleCompound': {between: [['10am', '11:59am'], ['11pm', '11:05pm']]}},
]
suite('Setup',(() => {
  test('load',((done) => {
    Questions.load({
      onReady: (questions) => {
        assert(questions._currentQuestion == 0)
        done()
    }})
  }))

  test('shuffle',((done) => {
    Questions.load({
      shuffle: true,
      history: [],
      questions: questions,
      onReady: (questions) => {
        let shuffled = JSON.stringify(questions.relevantQuestions)
        questions.shuffle = false
        let nonShuffled = JSON.stringify(questions._selectQuestionList())
        assert(shuffled != nonShuffled, 'shuffle should change order of questions')
        done()
      }
    })
  }))

  test('1 number',((done) => {
    Questions.load({
      number:  1,
      history: [],
      questions: questions,
      onReady: (questions) => {
        assert(questions.relevantQuestions.length == 1, 'control number of questions asked')
        done()
      }
    })
  }))

  test('3 number',((done) => {
    Questions.load({
      number:  3,
      history: [],
      questions: questions,
      onReady: (questions) => {
        assert(questions.relevantQuestions.length == 3, 'control number of questions asked')
        done()
      }
    })
  }))

  test('all',((done) => {
    Questions.load({
      number:  1,
      all: true,
      history: [],
      questions: questions,
      onReady: (questions) => {
        assert(questions.relevantQuestions.length > 1, 'all will override number')
        done()
      }
    })
  }))

  test('all',((done) => {
    Questions.load({
      number:  1,
      all: true,
      history: [],
      questions: questions,
      onReady: (questions) => {
        assert(questions.relevantQuestions.length > 1, 'all will override number')
        done()
      }
    })
  }))
}))
