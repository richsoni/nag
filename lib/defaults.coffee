C = require("./constants")

module.exports =
  command: C.COMMANDS.QUIZ
  affirmations:   ['yes', 'y']
  path:
    questions: C.PATHS.QUESTIONS
    completed: C.PATHS.COMPLETED
  flags:
    stern: false
    shuffle: true
    numberOfQuestions: 3
    all: false
