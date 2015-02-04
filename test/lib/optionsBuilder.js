require("../globals")
const OptionsBuilder = require("../../lib/optionsBuilder")
suite('Options Builder New', (() => {
  test('CLI Always wins',(() => {
    let testCommand = 'quiz'
    let testBool    = true
    let opts = OptionsBuilder.build({
      cliOpts: {defaultCommand: testCommand, nested: {boolKey: testBool}},
      config:  {defaultCommand: `!${testCommand}`, nested: {boolKey: !testBool}}
    })
    assert(opts.global.defaultCommand == testCommand)
    assert(opts.nested.boolKey == testBool)
  }))
}))
