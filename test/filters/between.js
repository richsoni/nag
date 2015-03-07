const moment   = require("moment")
const between  = require("../../filters/between")
require("../globals")
const FORMAT = 'hh:mma'

const truthy = {
  question: 'test',
  lastOccurance: moment().subtract(5, 'days'),
  filters: {
    between: [
      moment().subtract(5, 'minutes').format(FORMAT),
      moment().add(5, 'minutes').format(FORMAT)
    ]
  }
}


const falsy = {
  question: 'test',
  lastOccurance: moment().subtract(5, 'days'),
  filters: {
    between: [
      moment().subtract(5, 'minutes').format(FORMAT),
      moment().subtract(2, 'minutes').format(FORMAT)
    ]
  }
}
suite('Filters',(() =>
  test('Today',(() => {
    assert(between(truthy) == true)
    assert(between(falsy) == false)
}))))
