const deepExtend = require('deep-extend')
const CLIParser  = require("../lib/cliParser")
const C          = require("../lib/constants")
const defaults   = require("./defaults")

let cliOpts = new CLIParser({args: process.argv.slice(2), env: process.env})
let userConfig = require(C.PATHS.CONFIG)

module.exports = class OptionsBuilder {
  constructor(args = {}) {
    this.cliOpts     = args.cliOpts || cliOpts
    this._userConfig = args.config || userConfig
    this._config     = this._buildConfig()
    this.command     = this._command()
    this.flags       = this._flags()
  }

  _buildConfig() {
    return deepExtend({}, defaults, this._userConfig)
  }

  _command() {
    return this.cliOpts.command || this._config.global.defaultCommand
  }

  _flags() {
    return deepExtend({}, this._config.commands[this._command()], this.cliOpts.flags)
  }
}
