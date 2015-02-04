require("./globals")
const template = require("../config-template/config")
const defaults = require("../lib/defaults")

let sanitizeKeys = (object) => {
  return JSON.stringify(Object.keys(object).sort())
}

suite('config',(() =>
  test('template has all the same keys as defauts',() => {
      assert(sanitizeKeys(template) == sanitizeKeys(defaults), 'has same root level keys')
      assert(sanitizeKeys(template.global) == sanitizeKeys(defaults.global), 'has same global level keys')
      assert(sanitizeKeys(template.commands) == sanitizeKeys(defaults.commands), 'has same command level keys')
      assert(sanitizeKeys(template.commands.quiz) == sanitizeKeys(defaults.commands.quiz), 'has same quiz level keys')})))
