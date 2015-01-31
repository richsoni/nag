CLIParser    = require("../lib/cliParser")
ConfigParser = require("../lib/configParser")
defaults     = require("./defaults")

cliOptions = new CLIParser(args: process.argv.slice(2), env: process.env)
config     = new ConfigParser().config

module.exports = class OptionsBuilder
  constructor: (params = {}) ->
    @_config = params.config || config
    @_cliOptions = params.cliOptions || cliOptions

  _build: () ->
    keys = ['command']
    keys.forEach (key) => @_setOption(key, @)
    @flags = defaults.flags
    Object.keys(@flags).forEach (key) =>
      if @_cliOptions.flags?.hasOwnProperty(key)
        @flags[key] = @_cliOptions.flags[key]
      else if @_config.flags?.hasOwnProperty(key)
        @flags[key] = @_config.flags[key]

  _setOption: (key, obj) ->
    if @_cliOptions.hasOwnProperty(key) && !!@_cliOptions[key] != false
      obj[key] = @_cliOptions[key]
    else if @_config.hasOwnProperty(key)
      obj[key] = @_config[key]
    else
      obj[key] = defaults[key]

  @build: (params = {}) ->
    (options = new OptionsBuilder(params))._build()
    return options
