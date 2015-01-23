require("./globals")
Nag = require("../nagEntry")

suite 'Environment', ->
  test '$NAG_IGNORE', ->
    process.env.NAG_IGNORE=true
    nag = new Nag()
    assert(!!nag._started == false)
