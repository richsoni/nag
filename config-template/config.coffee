module.exports =
  global:
    defaultCommand:       'quiz'
    questionsPath: '~/.config/nag/questions.coffee'
    completedPath: '~/.config/nag/completed'
  commands:
    quiz:
      affirmations: ['yes', 'y']
      stern: false
      shuffle: true
      numberOfQuestions: 3
      all: false
