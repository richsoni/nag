require("../globals")
OptionsBuilder = require("../../lib/optionsBuilder")

CONFIG =
  command: 'edit'
  flags:
    stern: true

CLI =
  command: 'override'
  flags:
    stern: 'override'

suite 'Options Builder', ->
  test 'defaults', ->
    options = OptionsBuilder.build({config: {}, cliOptions: {}})
    assert options.command     == 'quiz', 'quiz expected to be default command'
    assert options.flags.stern == false, 'stern expected to be false'

  test 'options options', ->
    options = OptionsBuilder.build({config:CONFIG, cliOptions: {}})
    assert options.command     == 'edit', 'edit should be options'
    assert options.flags.stern == true, 'stern should be true'

  test 'cli overrides', ->
    options = OptionsBuilder.build({config:CONFIG, cliOptions: CLI})
    assert options.command     == 'override', 'override should be options'
    assert options.flags.stern == 'override', 'stern should be override'
