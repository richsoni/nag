require("../globals")
const OptionsBuilder = require("../../lib/optionsBuilder")
suite('Options Builder New', (() => {
  test('CLI Always wins',(() => {
    let testCommand = 'quiz'
    let opts = new OptionsBuilder({
      cliOpts: {defaultCommand: testCommand},
      config:  {defaultCommand: `!${testCommand}`}
    })
    assert(opts.command == testCommand)
  }))
}))
