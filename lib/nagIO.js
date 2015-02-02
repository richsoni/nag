const fs       = require('fs')
const readline = require('readline')
const stream   = require('stream')
const moment   = require("moment")
const C        = require("./constants")

module.exports = {
  loadHistory: (args) => {
    const {onEnd} = args
    const tasks = {}
    let instream  = fs.createReadStream(C.PATHS.COMPLETED)
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

  loadQuestions: () => {
    let data = require(C.PATHS.QUESTIONS)
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
  },

  logData: (data) => {
    return fs.appendFileSync(C.PATHS.COMPLETED, data)
  }
}
