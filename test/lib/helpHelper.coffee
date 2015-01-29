require("../globals")
HelpHelper = require("../../lib/helpHelper")
C          = require("../../lib/constants")

suite 'help helper', ->
  test 'no help', ->
    truthy = ['help', 'help x', 'help-quick', 'help-quick x']
    for test in truthy
      hh = new HelpHelper(test)
      assert hh.isHelp
    falsy = ['nag']
    for test in falsy
      hh = new HelpHelper(test)
      assert !hh.isHelp

  test 'regular path', () ->
    hh = new HelpHelper('help-quick')
    assert hh.path() == "#{C.PATHS.HELP.QUICK_DIR}/nag"
    hh = new HelpHelper('help')
    assert hh.path() == "#{C.PATHS.HELP.MAN_DIR}/nag"
    hh = new HelpHelper('help quiz')
    assert hh.path() == "#{C.PATHS.HELP.MAN_DIR}/quiz"
    hh = new HelpHelper('help-quick quiz')
    assert hh.path() == "#{C.PATHS.HELP.QUICK_DIR}/quiz"

suite 'help documentation', () ->
  test 'all commands have quick help', () ->
    for KEY, val of C.COMMANDS
      hh = new HelpHelper("help-quick #{val}")
      assert hh.fileExists(),"quick help does not exist for #{val} (#{hh.path()})"

  test 'all commands have long help', () ->
    for KEY, val of C.COMMANDS
      hh = new HelpHelper("help #{val}")
      assert hh.fileExists(),"longform help does not exist for #{val} (#{hh.path()})"
