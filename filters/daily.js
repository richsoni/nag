const moment   = require("moment")

module.exports = (task) => {
  if(task){
    let timestamp = task.split(' ')[0]
    let today = moment().format('YYYY-MM-DD')
    if(timestamp == today) {
      return false
    } else {
      return true
    }
  } else {
    return true
  }
}
