require("../globals")
CLIParser = require("../../lib/CLIParser")

suite 'commands', ->
  test 'nag', ->
    opts = new CLIParser(args: [])
    assert !!opts.command == false, 'no args == null'
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

  test 'Number of Questions', ->
    opts   = new CLIParser(args: ['--number-of-questions=3'])
    assert(opts.flags.numberOfQuestions == 3, '--number-of-questions=3 sets option to 3')
    opts   = new CLIParser(args: ['-n5'])
    assert(opts.flags.numberOfQuestions == 5, '-n5 sets option to 5')
    opts   = new CLIParser(args: ['--all'])
    assert(opts.flags.all == true, 'all')

  test 'Randomize Questions', ->
    opts   = new CLIParser(args: ['--randomize-questions'])
    assert(opts.flags.randomizeQuestions == true, '--randomize questions')
    opts   = new CLIParser(args: ['-r'])
    assert(opts.flags.randomizeQuestions == true, '--randomize questions is the same as -r')
