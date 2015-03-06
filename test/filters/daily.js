const moment   = require("moment")
require("../globals")
const daily = require("../../filters/daily")

const truthy = {
  question: 'test',
  lastOccurance: moment().subtract(5, 'days'),
  filters: {}
}
const falsy = {
  question: 'test',
  lastOccurance: moment(),
  filters: {}
}
suite('Filters',(() =>
  test('Today',(() => {
    assert(daily(truthy) == true)
    assert(daily(falsy) == false)
}))))
