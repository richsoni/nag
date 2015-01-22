# test to ensure mocha is correctly configured / installed
# use as an example for other tests

require("./globals")

suite 'mocha', ->
  test 'test', ->
    assert(1 == 1)
