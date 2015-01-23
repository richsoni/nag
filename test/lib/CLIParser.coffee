require("../globals")
CLIParser = require("../../lib/CLIParser")

suite 'commands', ->
  test 'nag', ->
    opts = new CLIParser(args: [])
    assert opts.command == 'nag', 'no args == nag'
    opts = new CLIParser(args: ['nag'])
    assert opts.command == 'nag', 'nag == nag'

  test 'edit', ->
    opts = new CLIParser(args: ['edit'])
    assert opts.command == 'edit', 'edit == edit'

suite 'Environment', ->
  test '$NAG_IGNORE', ->
    opts = new CLIParser(args: [], env: {NAG_IGNORE: 'true'})
    assert(opts.ignore == true, '$NAG_IGNORE == args.ignore')
