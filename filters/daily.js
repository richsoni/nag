const moment   = require("moment")

module.exports = (question) => {
  if(question.lastOccurance){
    let lastOccurance = question.lastOccurance.split(' ')[0]
    let today = moment().format('YYYY-MM-DD')
    if(lastOccurance == today) {
      return false
    } else {
      return true
    }
  } else {
    return true
  }
}
