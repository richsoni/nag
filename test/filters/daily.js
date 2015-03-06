const moment   = require("moment")
require("../globals")
const daily = require("../../filters/daily")

suite('Filters',(() =>
  test('Today',(() => {
    assert(daily("2014-12-01 task 1") == true)
    assert(daily(`${moment().format('YYYY-MM-DD')} task 1`) == false)
}))))
