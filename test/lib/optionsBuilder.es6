require("../globals")
const OptionsBuilder = require("../../lib/optionsBuilder")

const CONFIG = {
  command: 'edit',
  flags: {
    stern: true
  }
}

const CLI = {
  command: 'override',
  flags: {
    stern: 'override'
  }
}

suite('Options Builder',(() => {
  test('defaults',(() => {
    let options = OptionsBuilder.build({config: {}, cliOptions: {}})
    assert(options.command     == 'quiz', 'quiz expected to be default command')
    assert(options.flags.stern == false, 'stern expected to be false')
  }))
  test('cli overrides',(() => {
    let options = OptionsBuilder.build({config:CONFIG, cliOptions: CLI})
    assert(options.command     == 'override', 'override should be options')
    assert(options.flags.stern == 'override', 'stern should be override')
  }))
}))
