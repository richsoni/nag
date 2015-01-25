# ../test/lib/CLIParser.coffee
inflection = require("inflection")
FLAG = /^--(.*)$/
FLAGOFF = /^no-(.*)$/

module.exports = class CLIParser
  constructor: (params = {}) ->
    @_args     = params.args || []
    @_env      = params.env  || []
    @_setCommandsAndFlags()
    @_setCommand()
    @_setEnvOptions()

  _setCommandsAndFlags: () ->
    @commands = []
    @flags    = {}
    @_args.forEach (arg) =>
      if res = arg.match(FLAG)
        flag = res[1]
        if res = flag.match(FLAGOFF)
          flag = res[1]
          value = false
        else
          value = true
        @flags[@_flagToKey(flag)] = value
      else
        @commands.push(arg)

  _flagToKey: (flag) -> inflection.camelize(flag.replace('-', '_'), true)

  _setCommand: () ->
    switch @commands.length
      when 0 then @command = null
      when 1 then @command = @_args[0]

  _setEnvOptions: () ->
    @ignore = @_env.NAG_IGNORE == 'true'
