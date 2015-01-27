# ../test/lib/CLIParser.coffee
minimist   = require("minimist")
inflection = require("inflection")
ALIASES = {
  'n': 'number-of-questions'
  's': 'shuffle'
}

module.exports = class CLIParser
  constructor: (params = {}) ->
    @_args     = minimist(params.args, {alias: ALIASES})
    @command   = @_args._[0]
    @flags     = @_setFlags()
    @_env      = params.env || []
    @_setEnvOptions()

  _setFlags: () ->
    Object.keys(@_args).reduce(((memo, key) =>
      if key != '_'
        memo[@_flagToKey(key)] = @_args[key]
      memo
    ),{})

  _flagToKey: (flag) -> inflection.camelize(flag.replace(/-/g, '_', 'i'), true)

  _setEnvOptions: () ->
    @ignore = @_env.NAG_IGNORE == 'true'
