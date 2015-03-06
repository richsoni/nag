const moment = require("moment")
const FORMAT = 'YYYY-MM-DD'

module.exports = (question) => {
  if(question.lastOccurance){
    let lastOccurance = question.lastOccurance.format(FORMAT)
    let today = moment().format(FORMAT)
    if(lastOccurance == today) {
      return false
    } else {
      return true
    }
  } else {
    return true
  }
}
