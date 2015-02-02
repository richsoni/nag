const C  = require("./constants")
const fs = require("fs")

module.exports = class HelpHelper {
  constructor(command) {
    this._commands = command.split(' ')
    this.isQuick = false
    this.isHelp  = false
    this.search  = this._commands.slice(1,this._commands.length).join(' ')
    if(this._commands[0] == C.HELP_COMMANDS.QUICK){
      this.isQuick = true
      this.isHelp  = true
    }
    else if(this._commands[0] == C.HELP_COMMANDS.LONG){
      this.isHelp  = true
    }
  }

  path() {
    if(!this.isHelp) return ""
    let path = ""
    let commands = this._commands.slice(1,this._commands.length)
    let c = commands.join('/')
    if(this.isQuick){
      path = `${C.PATHS.HELP.QUICK_DIR}`
    } else {
      path = `${C.PATHS.HELP.MAN_DIR}`
    }
    if(commands.length){
      path = `${path}/${c}`
    } else {
      path = `${path}/nag`
    }
    return path
  }

  fileExists() {
    try {
      fs.statSync(this.path())
    }
    catch (e){
      return false
    }
    return true
  }
}
