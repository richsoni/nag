home = process.env.HOME

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
C.PATHS.CONFIG_DIR = "#{home}/.config/nag"
C.PATHS.QUESTIONS  = "#{C.PATHS.CONFIG_DIR}/questions.coffee"
C.PATHS.COMPLETED  = "#{C.PATHS.CONFIG_DIR}/completed"
C.PATHS.CONFIG     = "#{C.PATHS.CONFIG_DIR}/config.coffee"

C.PATHS.HELP = {}
C.PATHS.HELP.QUICK_DIR   = "#{home}/nag/doc/quick"
C.PATHS.HELP.MAN_DIR     = "#{home}/nag/doc/man"

C.SWITCHES = {}
C.SWITCHES.NAG_IGNORE = 'true'

module.exports = C