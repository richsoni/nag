CLIParser  = require("../lib/cliParser")
C          = require("../lib/constants")
cliOptions = new CLIParser(args: process.argv.slice(2), env: process.env)

defaults   = require("./defaults")
config     = require(C.PATHS.CONFIG)

module.exports = class ConfigBuilder
  constructor: (params = {}) ->
    @_config = params.config || config
    @_cliOptions = params.cliOptions || cliOptions

  _build: () ->
    keys = ['command']
    keys.forEach (key) =>
      if @_cliOptions.hasOwnProperty(key) && !!@_cliOptions[key] != false
        @[key] = @_cliOptions[key]
      else if @_config.hasOwnProperty(key)
        @[key] = @_config[key]
      else
        @[key] = defaults[key]
    @flags = defaults.flags
    Object.keys(@flags).forEach (key) =>
      if @_cliOptions.flags?.hasOwnProperty(key)
        @flags[key] = @_cliOptions.flags[key]
      else if @_config.flags?.hasOwnProperty(key)
        @flags[key] = @_config.flags[key]

  @build: (params = {}) ->
    (config = new ConfigBuilder(params))._build()
    return config
