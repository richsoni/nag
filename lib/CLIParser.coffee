# ../test/lib/CLIParser.coffee

module.exports = class CLIParser
  constructor: (params = {}) ->
    {args, env} = params
    args  ||= []
    env   ||= {}
    switch args.length
      when 0 then @command = 'nag'
      when 1 then @command = args[0]
    @ignore = env.NAG_IGNORE == 'true'
