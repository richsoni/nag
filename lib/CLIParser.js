// ../test/lib/CLIParser.coffee
const minimist   = require("minimist")
const inflection = require("inflection")
const C          = require("./constants")

module.exports = class CLIParser {
  constructor(params = {}) {
    this._args   = minimist(params.args, {alias: C.CLI.ALIASES})
    this.command = this._args._.join(' ')
    this.flags   = this._transformFlags()
    this.command = this._quickHelpSpecialCase()
  }

  _isQuickHelp() {
    return this.flags.help || this._isBaseHelp()
  }

  _isBaseHelp() {
    return this.command == C.HELP_COMMANDS.LONG
  }

  _quickHelpSpecialCase() {
    if(this._isQuickHelp()){
      if(this._isBaseHelp()){
        return C.HELP_COMMANDS.QUICK
      } else {
        return `${C.HELP_COMMANDS.QUICK} ${this.command}`
      }
    } else {
      return this.command
    }
  }

  _transformFlags() {
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
}
