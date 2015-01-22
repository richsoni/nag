#! /usr/bin/env coffee
readline  = require("readline")

class Readline
  constructor: () ->
    @_readline = @newReadline()

  newReadline: () ->
    @_readline = readline.createInterface({
      input:    process.stdin
      output:   process.stdout
      terminal: true})
    .on('SIGINT', @_onSIGINT.bind(@))
    .on('close', @_onClose.bind(@))

  question: (q, callback) ->
    @_readline.question(q, callback)

  _onSIGINT: () ->


  _onClose: () ->
    old = @_readline
    @_readline = @newReadline()
    old.close()

rl = new Readline()
