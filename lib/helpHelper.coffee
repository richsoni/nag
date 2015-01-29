C  = require("./constants")
fs = require("fs")

module.exports = class HelpHelper
  constructor: (command) ->
    @_commands = command.split(' ')
    @isQuick = false
    @isHelp  = false
    @search  = @_commands.slice(1,@_commands.length).join(' ')
    if @_commands[0] == C.HELP_COMMANDS.QUICK
      @isQuick = true
      @isHelp  = true
    else if @_commands[0] == C.HELP_COMMANDS.LONG
      @isHelp  = true

  path: () ->
    return "" if !@isHelp
    commands = @_commands.slice(1,@_commands.length)
    c = commands.join('/')
    if @isQuick
      path = "#{C.PATHS.HELP.QUICK_DIR}"
    else
      path = "#{C.PATHS.HELP.MAN_DIR}"
    if commands.length
      path = "#{path}/#{c}"
    else
      path = "#{path}/nag"
    return path

  fileExists: () ->
    try
      fs.statSync(@path())
    catch
      false
