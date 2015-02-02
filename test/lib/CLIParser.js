require("../globals")
const CLIParser = require("../../lib/CLIParser")
const C         = require("../../lib/constants")

suite('commands',(() =>
  test('all commands', () => {
    let opts = new CLIParser({args: []})
    assert(!!opts.config.command == false, 'no args == null')
    for(let KEY in C.COMMANDS){
      let val = C.COMMANDS[KEY]
      opts = new CLIParser({args: [val]})
      assert(opts.config.command == val, `${val} == ${val}`)}})))

suite('Environment',(() =>
  test('$NAG_IGNORE',(() => {
    let opts = new CLIParser({args: [], env: {NAG_IGNORE: 'true'}})
    assert(opts.ignore == true, '$NAG_IGNORE == args.ignore')
}))))

suite('Global Flags',(() => {
  test('stern mode',(() => {
    let opts = new CLIParser({args: ['--stern']})
    assert(opts.config.options.stern == true, '--stern turns on stern flag')
    opts = new CLIParser({args: ['--no-stern']})
    assert(opts.config.options.stern == false, '--no-stern forces no stern')
    opts  = new CLIParser({args: ['--stern', '--no-stern']})
    assert(opts.config.options.stern == false, 'last arg is the one that is active')}))

  test('Number of Questions',(() => {
    let opts   = new CLIParser({args: ['--number-of-questions=3']})
    assert(opts.config.options.numberOfQuestions == 3, '--number-of-questions=3 sets option to 3')
    opts   = new CLIParser({args: ['-n5']})
    assert(opts.config.options.numberOfQuestions == 5, '-n5 sets option to 5')
    opts   = new CLIParser({args: ['--all']})
    assert(opts.config.options.all == true, 'all')
  }))

  test('Randomize Questions',(() => {
    let opts   = new CLIParser({args: ['--shuffle']})
    assert(opts.config.options.shuffle == true, '--shuffle questions')
    opts   = new CLIParser({args: ['-s']})
    assert(opts.config.options.shuffle == true, '--shuffle questions is the same as -s')
  }))
}))

suite('Help',(() => {
  test('help is joined with a string',(() => {
    let opts   = new CLIParser({args: ['help', 'nag']})
    assert(opts.config.command == `${C.HELP_COMMANDS.LONG} nag`, 'help joins space')
  }))

  test('-h proxies to quick help command',(() => {
    let opts   = new CLIParser({args: ['quiz', '-h']})
    assert(opts.config.command == `${C.HELP_COMMANDS.QUICK} quiz`, 'quickhelp')
  }))
}))
