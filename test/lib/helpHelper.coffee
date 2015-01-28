require("../globals")
HelpHelper    = require("../../lib/helpHelper")
ConfigBuilder = require("../../lib/configBuilder")
C             = require("../../lib/constants")

suite 'HelpHelper', ->
  test 'standard help commend', () ->
    assert "#{C.PATHS.HELP.QUICK_DIR}/nag" == "#{C.PATHS.HELP.QUICK_DIR}/nag"
