// ../test/lib/CLIParser.coffee
const minimist   = require("minimist")
const inflection = require("inflection")
const C          = require("./constants")

module.exports = class CLIParser {
  constructor(params = {}) {
    this._args     = minimist(params.args, {alias: C.CLI.ALIASES})
    this.config    = {command: null, options: {}}
    this.config.command = this._args._.join(' ')
    this.config.options = this._setFlags()
    this._quickHelpSpecialCase()
    this._env      = params.env || []
    this._setEnvOptions()
  }

  _quickHelpSpecialCase() {
    if(this.config.options.help){
      this.config.command = `${C.HELP_COMMANDS.QUICK} ${this.config.command}`
    } else if(this.config.command == C.HELP_COMMANDS.LONG){
      this.config.command = C.HELP_COMMANDS.QUICK
    }
  }

  _setFlags() {
    return Object.keys(this._args).reduce((memo, key) => {
      if(key != '_'){
        memo[this._flagToKey(key)] = this._args[key]
      }
      return memo
    }.bind(this),{})
  }

  _flagToKey(flag) {
    return inflection.camelize(flag.replace(/-/g, '_', 'i'), true)
  }

  _setEnvOptions() {
    this.ignore = this._env.NAG_IGNORE == C.SWITCHES.NAG_IGNORE
  }
}
