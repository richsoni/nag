const home = process.env.HOME

let C = {}
C.COMMANDS = {}
C.COMMANDS.EDIT   = 'edit'
C.COMMANDS.CONFIG = 'config'
C.COMMANDS.QUIZ   = 'quiz'
C.COMMANDS.STAT   = 'stat'

C.HELP_COMMANDS = {}
C.HELP_COMMANDS.LONG  = 'help'
C.HELP_COMMANDS.QUICK = 'help-quick'

C.CLI = {}
C.CLI.ALIASES = {
  'n': 'number-of-questions',
  's': 'shuffle',
  'a': 'all',
  'h': 'help'
}

C.DEFAULTS = {}
C.DEFAULTS.EDITOR = 'vi'

C.PATHS = {}
C.PATHS.CONFIG_DIR = `${home}/.config/nag`
C.PATHS.QUESTIONS  = `${C.PATHS.CONFIG_DIR}/questions.js`
C.PATHS.COMPLETED  = `${C.PATHS.CONFIG_DIR}/completed`
C.PATHS.CONFIG     = `${C.PATHS.CONFIG_DIR}/config.js`

C.PATHS.HELP = {}
C.PATHS.HELP.QUICK_DIR   = `${home}/nag/doc/quick`
C.PATHS.HELP.MAN_DIR     = `${home}/nag/doc/man`

C.SWITCHES = {}
C.SWITCHES.NAG_IGNORE = 'true'

module.exports = C
