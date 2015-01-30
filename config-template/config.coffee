module.exports =
  default: 'quiz'
  paths:
    questions: '~/.config/nag/questions.coffee'
    completed: '~/.config/nag/completed'
  affirmations: ['yes', 'y']
  flags:
    stern: false
    shuffle: true
    numberOfQuestions: 3
    all: false
