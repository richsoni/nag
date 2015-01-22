#! /usr/bin/env coffee
readline  = require("readline")

# Disable CTRL-D, CTRL-C
# TODO need to forward if its not a close command
ttyWrite  = readline.Interface.prototype._ttyWrite
readline.Interface.prototype._ttyWrite = (s, key) ->
  unless key.ctrl && (key.name == 'd' || key.name == 'c')
    ttyWrite.bind(@)(s, key)

module.exports = class NagReadline
  constructor: () ->
    @newReadline()

  newReadline: () ->
    @_readline = readline.createInterface({
      input:    process.stdin
      output:   process.stdout
    })

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
