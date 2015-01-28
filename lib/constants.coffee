C = {}
C.COMMANDS = {}
C.COMMANDS.HELP   = 'help'
C.COMMANDS.EDIT   = 'edit'
C.COMMANDS.CONFIG = 'config'
C.COMMANDS.QUIZ   = 'quiz'

C.CLI = {}
C.CLI.ALIASES = {
  'n': 'number-of-questions'
  's': 'shuffle'
  'a': 'all'
}

C.DEFAULTS = {}
C.DEFAULTS.EDITOR = 'vi'

C.PATHS = {}
C.PATHS.QUESTIONS = "#{process.env.HOME}/.config/nag/questions.coffee"
C.PATHS.COMPLETED = "#{process.env.HOME}/.config/nag/completed"
C.PATHS.CONFIG    = "#{process.env.HOME}/.config/nag/config.coffee"

C.SWITCHES = {}
C.SWITCHES.NAG_IGNORE = 'true'
module.exports = C
