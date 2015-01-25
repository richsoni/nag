module.exports =
  command: 'nag'
  affirmations:   ['yes', 'y']
  path:
    questions: '~/.config/nag/questions.coffee'
    completed: '~/.config/nag/completed'
  flags:
    stern: false
