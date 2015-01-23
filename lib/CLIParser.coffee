# ../test/lib/CLIParser.coffee

module.exports = class CLIParser
  constructor: (args = []) ->
    switch args.length
      when 0 then @command = 'nag'
      when 1 then @command = args[0]
