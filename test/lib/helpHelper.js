require("../globals")
const HelpHelper = require("../../lib/helpHelper")
const C          = require("../../lib/constants")

suite('help helper',(() => {
  test('no help',(() => {
    let truthy = ['help', 'help x', 'help-quick', 'help-quick x']
    for(test of truthy){
      let hh = new HelpHelper(test)
      assert(hh.isHelp, `${test} should be help`)
    }
    let falsy = ['nag']
    for(test of falsy){
      let hh = new HelpHelper(test)
      assert(!hh.isHelp, `${test} should not be help`)
    }
  }))

  test('regular path',(() => {
    let hh = new HelpHelper('help-quick')
    assert(hh.path() == `${C.PATHS.HELP.QUICK_DIR}/nag`)
    hh = new HelpHelper('help')
    assert(hh.path() == `${C.PATHS.HELP.MAN_DIR}/nag`)
    hh = new HelpHelper('help quiz')
    assert(hh.path() == `${C.PATHS.HELP.MAN_DIR}/quiz`)
    hh = new HelpHelper('help-quick quiz')
    assert(hh.path() == `${C.PATHS.HELP.QUICK_DIR}/quiz`)
  }))
}))

suite('help documentation',(() => {
  test('all commands have quick help',(() => {
    for(let KEY in C.COMMANDS){
      let val = C.COMMANDS[KEY]
      let hh = new HelpHelper(`help-quick ${val}`)
      assert(hh.fileExists(),`quick help does not exist for ${val} (${hh.path()})`)
    }
  }))

  test('all commands have long help',(() => {
    for(let KEY in C.COMMANDS){
      let val = C.COMMANDS[KEY]
      let hh = new HelpHelper(`help ${val}`)
      assert(hh.fileExists(),`longform help does not exist for ${val} (${hh.path()})`)
    }
  }))

  test('quick-help files map to proper file',(() => {
    for(let KEY in C.COMMANDS){
      let val = C.COMMANDS[KEY]
      let hh = new HelpHelper(`help-quick ${val}`)
      assert(hh.path() == `${C.PATHS.HELP.QUICK_DIR}/${val}`, `${val} quick-help file mismatch`)
    }
  }))

  test('help files map to proper file',(() => {
    for(let KEY in C.COMMANDS){
      let val = C.COMMANDS[KEY]
      let hh = new HelpHelper(`help ${val}`)
      console.log(hh.path(), val)
      assert(hh.path() == `${C.PATHS.HELP.MAN_DIR}/${val}`, `${val} quick-help file mismatch`)
    }
  }))
}))
