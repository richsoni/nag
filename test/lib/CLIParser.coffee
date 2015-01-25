require("../globals")
CLIParser = require("../../lib/CLIParser")

suite 'commands', ->
  test 'nag', ->
    opts = new CLIParser(args: [])
    assert opts.hasOwnProperty('command') == false, 'no args == null'
    opts = new CLIParser(args: ['nag'])
    assert opts.command == 'nag', 'nag == nag'

  test 'edit', ->
    opts = new CLIParser(args: ['edit'])
    assert opts.command == 'edit', 'edit == edit'

  test 'config', ->
    opts = new CLIParser(args: ['config'])
    assert opts.command == 'config', 'config == config'

suite 'Environment', ->
  test '$NAG_IGNORE', ->
    opts = new CLIParser(args: [], env: {NAG_IGNORE: 'true'})
    assert(opts.ignore == true, '$NAG_IGNORE == args.ignore')

suite 'Global Flags', ->
  test 'stern mode', ->
    opts   = new CLIParser(args: ['--stern'])
    assert(opts.flags.stern == true, '--stern turns on stern flag')
    opts = new CLIParser(args: ['--no-stern'])
    assert(opts.flags.stern == false, '--no-stern forces no stern')
    optns  = new CLIParser(args: ['--stern', '--no-stern'])
    assert(opts.flags.stern == false, 'last arg is the one that is active')
