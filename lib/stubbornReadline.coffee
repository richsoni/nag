#! /usr/bin/env coffee
readline  = require("readline")

# Disable CTRL-D
ttyWrite  = readline.Interface.prototype._ttyWrite
readline.Interface.prototype._ttyWrite = (s, key) ->
  unless key.ctrl && key.name == 'd'
    ttyWrite.bind(@)(s, key)

module.exports = class Readline
  constructor: () ->
    @newReadline()

  newReadline: () ->
    @_readline = readline.createInterface({
      input:    process.stdin
      output:   process.stdout
    })
    @_readline.on('SIGINT', @_onSIGINT.bind(@))
    @_readline.on('close', @_onClose.bind(@))
    @_readline.input.addListener('attemptClose', () -> console.log("ther"))

  question: (args) ->
    {question, onAnswer} = args
    @_question = args
    @_answer   = null
    @_readline.question(question, (answer) =>
      @_answer = answer
      if @_answer
        onAnswer(answer)
      else
        @question(@_question)
    )

  close: () -> @_readline.close()

  _onSIGINT: () ->

  _onClose: () ->
    console.log("here")
    @_readline.close()
  #   unless @_answer
  #     @question(@_question)
