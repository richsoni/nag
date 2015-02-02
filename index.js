const fs             = require("fs")
const Stream         = require("stream")
const Questions      = require("./lib/questions")
const OptionsBuilder = require("./lib/optionsBuilder")

module.exports = class Nag {
  constructor(params = {}) {
    let {interactive, opts} = params
    this.opts = opts || OptionsBuilder.build()
    if(interactive){
      this.cli()
    }
  }

  cli() {
    let NagReadline = require("./lib/nagReadline")
    Questions.load({
      shuffle: this.opts.flags.shuffle,
      number:  this.opts.flags.numberOfQuestions,
      all:     this.opts.flags.all,
      onReady: (questions) => {
        if(!questions.currentQuestion()){
          process.exit(0)
        }
        let nextQuestion = () => {
          questions.nextQuestion()
          if(!questions.currentQuestion()){
            process.exit(0)
          }
          readline.question({
            question: questions.currentQuestionToS(),
            onAnswer: onAnswer
          })
        }
        let onAnswer = (answer) => {
          if(answer == 'yes'){
            questions.logCurrent()
          }
          nextQuestion()
        }
        let readline  = new NagReadline({stern: this.opts.flags.stern})
        readline.question({
          question: questions.currentQuestionToS(),
          onAnswer: onAnswer
        })
      }
    })
  }
}
