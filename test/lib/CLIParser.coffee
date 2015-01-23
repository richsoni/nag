require("../globals")
CLIParser = require("../../lib/CLIParser")

suite 'commands', ->
  test 'nag', ->
    args = new CLIParser([])
    assert args.command == 'nag'
    args = new CLIParser(['nag'])
    assert args.command == 'nag'

  test 'edit', ->
    args = new CLIParser(['edit'])
    assert args.command == 'edit'
