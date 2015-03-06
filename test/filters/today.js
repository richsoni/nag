const moment   = require("moment")
require("../globals")
const today = require("../../filters/today")

suite('Filters',(() =>
  test('Today',(() => {
    assert(today("2014-12-01 task 1") == true)
    assert(today(`${moment().format('YYYY-MM-DD')} task 1`) == false)
}))))

