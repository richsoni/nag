const moment = require("moment")
const NOW    = moment()
module.exports = (hash) => {
  if(hash.filters.between){
    //supports only am and pm now
    let FORMATS = ['hh:mma', 'hha']
    let start = moment(hash.filters.between[0], FORMATS)
    let end   = moment(hash.filters.between[1], FORMATS)
    return ((start <= NOW) && (NOW <= end))
  } else {
    return true
  }
}
