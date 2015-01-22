fs = require('fs')
readline = require('readline')
stream = require('stream')
moment = require("moment")
module.exports =
  loadHistory: (args) ->
    {onEnd} = args
    tasks = {}
    instream  = fs.createReadStream("/Users/rich/.nag/data")
    outstream = new stream
    rl = readline.createInterface(instream, outstream)
    rl.on 'line', (line) ->
      parts = line.split(' ')
      date  = moment(parts.shift())
      task  = parts.join(' ')
      if tasks[task]
        tasks[task] = date if date > tasks[task]
      else
        tasks[task] = date
    rl.on 'close', () ->
      onEnd(tasks)

  loadQuestions: () ->
    data = require("/Users/rich/.nag/questions")
    data.map (question) ->
      switch typeof question
        when 'string' then {question: question, filters: null}
        when 'object'
          name = Object.keys(question)[0]
          {question: name, filters: question[name]}

  logData: (data) ->
    fs.appendFileSync '/Users/rich/.nag/data', data
