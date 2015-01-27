module.exports =
  command: 'nag'
  affirmations:   ['yes', 'y']
  numberOfQuestions: 3
  quizRandom: true
  path:
    questions: '~/.config/nag/questions.coffee'
    completed: '~/.config/nag/completed'
  flags:
    stern: false
