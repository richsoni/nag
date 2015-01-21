module.exports = {
  loadQuestions: () ->
    data = require("/Users/rich/.nag/questions")
    data.map (question) ->
      switch typeof question
        when 'string' then {question: question}
        when 'object'
          name = Object.keys(question)[0]
          {question: name, filters: question[name]}
}
