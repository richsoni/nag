const readline  = require("readline")

module.exports = class NagReadline {
  constructor(params = {}) {
    if(params.stern) this._sternMode()
    this.newReadline()
  }

  _sternMode() {
    // Disable CTRL-D, CTRL-C
    // TODO need to forward if its not a close command
    let ttyWrite  = readline.Interface.prototype._ttyWrite
    readline.Interface.prototype._ttyWrite = function (s, key = {}) {
      if(!(key.ctrl && (key.name == 'd' || key.name == 'c'))){
        ttyWrite.bind(this)(s, key)
      }
    }
  }


  newReadline() {
    this._readline = readline.createInterface({
      input:    process.stdin,
      output:   process.stdout
    })
  }

  question(args) {
    let {question, onAnswer} = args
    this._question = args
    this._answer   = null
    this._readline.question(question, (answer) => {
      this._answer = answer
      if(this._answer){
        onAnswer(answer)
      } else {
        this.question(this._question)
      }
    }.bind(this))
  }
}
