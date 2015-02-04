const C = require("./constants")

module.exports = {
  global: {
    defaultCommand: C.COMMANDS.QUIZ,
    questionsPath: C.PATHS.QUESTIONS,
    completedPath: C.PATHS.COMPLETED
  },
  commands: {
    quiz: {
      affirmations:   ['yes', 'y'],
      stern: false,
      shuffle: true,
      numberOfQuestions: 3,
      all: false
    }
  }
}
