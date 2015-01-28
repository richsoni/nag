C = require("./constants")
module.exports = class HelpHelper
  constructor: (config) ->
    @path = "#{C.PATHS.HELP.QUICK_DIR}/nag"
