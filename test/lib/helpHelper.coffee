require("../globals")
HelpHelper    = require("../../lib/helpHelper")
ConfigBuilder = require("../../lib/configBuilder")
C             = require("../../lib/constants")


suite 'HelpHelper', ->
  test 'standard help commend', () ->
    helper = new HelpHelper(ConfigBuilder.build())
    assert helper.path == "#{C.PATHS.HELP.QUICK_DIR}/nag"
