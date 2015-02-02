const CLIParser    = require("../lib/cliParser")
const ConfigParser = require("../lib/configParser")
const defaults     = require("./defaults")

let cliOptions = new CLIParser({args: process.argv.slice(2), env: process.env})
let config     = new ConfigParser().toOptions()

module.exports = class OptionsBuilder {
  constructor(params = {}) {
    this._config = params.config || config
    this._cliOptions = params.cliOptions || cliOptions
  }

  _build() {
    let keys = ['command']
    keys.forEach((key) => {this._setOption(key, this)})
    this.flags = defaults.flags
    Object.keys(this.flags).forEach((key) =>{
      let options = this._cliOptions.config.options
      if(options && options.hasOwnProperty(key)){
        this.flags[key] = this.options[key]
      }
      else if(this._config.flags && this._config.flags.hasOwnProperty(key)){
        this.flags[key] = this._config.flags[key]
      }
    }.bind(this))
  }

  _setOption(key, obj) {
    let config = this._cliOptions.config
    if(config.hasOwnProperty(key) && !!config[key] != false){
      obj[key] = config[key]
    }
    else if(this._config.hasOwnProperty(key)){
      obj[key] = this._config[key]
    }
    else {
      obj[key] = defaults[key]
    }
  }

  static build(params = {}) {
    let options = new OptionsBuilder(params)
    options._build()
    return options
  }
}
