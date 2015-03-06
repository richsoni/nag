const io           = require("./nagIO")
const daily        = require("../filters/daily")
const moment       = require("moment")
const shuffleArray = require("shuffle-array")
const NOW          = moment()

class Question {
  constructor(args) {
    let {question, filters, lastOccurance} = args
    this.question      = question
    this.lastOccurance = lastOccurance
    this.filters       = filters || {}
  }

  toHash() {
    return {
      question: this.question,
      lastOccurance: this.lastOccurance,
      filters: this.filters
    }
  }

  testBetween() {
    if(this.filters.between){
      //supports only am and pm now
      let FORMATS = ['hh:mma', 'hha']
      let start = moment(this.filters.between[0], FORMATS)
      let end   = moment(this.filters.between[1], FORMATS)
      return ((start <= NOW) && (NOW <= end))
    } else {
      return true
    }
  }
}

module.exports = class Questions {
  static load(args) {
    let {onReady, shuffle, number, all, history, questions} = args
    if(history){
      onReady(new Questions({history: history, opts:{shuffle, number, all}, questions: questions}))
    } else {
      io.loadHistory({
        onEnd: (history) => {
          onReady(new Questions({history: history, opts:{shuffle, number, all}, questions: questions}))
        }
      })
    }
  }

  constructor(args) {
    this.history = args.history
    this.opts    = args.opts
    this._loadQuestions(args.questions)
    this.relevantQuestions = this._selectQuestionList()
  }

  _loadQuestions(questions) {
    let questions = io.loadQuestions(questions).map((q) => {
      return new Question({question: q.question, filters: q.filters, lastOccurance: this.history[q.question]})
    }.bind(this))
    this._questions = questions.reduce(((memo, question) => {
      if(this._isRelevant(question)){
        return memo.concat(question)
      }
      else {
        return memo
      }
    }.bind(this)), [])
  }

  _isRelevant(question) {
    if(!question.testBetween()) return false
    return daily(question.toHash())
  }


  _selectQuestionList() {
    this._currentQuestion = 0
    let questions = this._questions
    if(this.opts.shuffle){
      questions = shuffleArray(this._questions, {copy:true})
    }
    if(this.opts.number && !this.opts.all){
      questions = questions.slice(0,this.opts.number)
    }
    return questions
  }


  currentQuestion() {
    if(this.relevantQuestions[this._currentQuestion]){
      return this.relevantQuestions[this._currentQuestion].question
    }
  }

  nextQuestion() {
    return this._currentQuestion = this._currentQuestion + 1
  }

  currentQuestionToS() {
    return `> did you ${this.currentQuestion()} today? `
  }

  logCurrent() {
    let timestamp = moment().format('YYYY-MM-DD')
    return io.logData(`${timestamp} ${this.currentQuestion()}\n`)
  }
}
