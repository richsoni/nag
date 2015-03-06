const moment   = require("moment")
require("../globals")
const daily = require("../../filters/daily")

const truthy = {
  question: 'test',
  lastOccurance: '2014-12-01 task 1',
  filters: {}
}
const falsy = {
  question: 'test',
  lastOccurance: `${moment().format('YYYY-MM-DD')} task 1`,
  filters: {}
}
suite('Filters',(() =>
  test('Today',(() => {
    assert(daily(truthy) == true)
    assert(daily(falsy) == false)
}))))
