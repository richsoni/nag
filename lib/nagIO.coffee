module.exports = {
  loadQuestions: () ->
    data = require("/Users/rich/.nag/questions")
    data.map (question) ->
      switch typeof question
        when 'string' then {question: question, filters: null}
        when 'object'
          name = Object.keys(question)[0]
          {question: name, filters: question[name]}

  history: () =>
    #TODO print history in reverse for speed optimization
    require("/Users/rich/.nag/data.coffee").reverse()
}
