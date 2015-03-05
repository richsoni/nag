const fs       = require('fs')
const readline = require('readline')
const stream   = require('stream')
const moment   = require("moment")
const C        = require("./constants")

const sanitizeQuestions = (data) => {
  return data.map((question) => {
    switch(typeof question){
      case 'string':
        return {question: question, filters: null}
        break
      case 'object':
        let name = Object.keys(question)[0]
        return {question: name, filters: question[name]}
        break
    }
  })
}


module.exports = {
  loadHistory: (args) => {
    const {onEnd, cachedValues, historyPath} = args
    if (cachedValues){ return cachedValues }
    const tasks = {}
    let instream  = fs.createReadStream(historyPath || C.PATHS.COMPLETED)
    let outstream = new stream
    let rl = readline.createInterface(instream, outstream)
    rl.on('line',((line) => {
      let parts = line.split(' ')
      let date  = moment(parts.shift())
      let task  = parts.join(' ')
      if(tasks[task]){
       if(date > tasks[task]){
        tasks[task] = date
      }} else {
        tasks[task] = date
      }
    }))
    rl.on('close',(() => {
      onEnd(tasks)
    }))
  },

  loadQuestions: (cachedValues) => {
    if(cachedValues){
      return sanitizeQuestions(cachedValues)
    } else {
      let data = require(C.PATHS.QUESTIONS)
      return sanitizeQuestions(data)
    }
  },

  logData: (data) => {
    return fs.appendFileSync(C.PATHS.COMPLETED, data)
  }
}
