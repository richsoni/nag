require("../globals")
ConfigBuilder = require("../../lib/configBuilder")

CONFIG =
  command: 'edit'
  flags:
    stern: true

CLI =
  command: 'override'
  flags:
    stern: 'override'

suite 'Config Builder', ->
  test 'defaults', ->
    config = ConfigBuilder.build({config: {}, cliOptions: {}})
    assert config.command     == 'nag', 'nag expected to be default command'
    assert config.flags.stern == false, 'stern expected to be false'

  test 'config options', ->
    config = ConfigBuilder.build({config:CONFIG, cliOptions: {}})
    assert config.command     == 'edit', 'edit should be config'
    assert config.flags.stern == true, 'stern should be true'

  test 'cli overrides', ->
    config = ConfigBuilder.build({config:CONFIG, cliOptions: CLI})
    assert config.command     == 'override', 'override should be config'
    assert config.flags.stern == 'override', 'stern should be override'
