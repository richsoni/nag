BEFORE_BED  = ['10pm', '11:59pm']
ARRIVE_WRK  = ['9am', '11am']
AFTER_WRK   = ['6pm', '11:59pm']
QUICK_CHECK = {between: [ARRIVE_WRK, BEFORE_BED]}

module.exports = [
  'work out': {between: AFTER_WRK}
  'dvorak speed test'
  'have nicotine': QUICK_CHECK
  'duolingo'
  'journal': QUICK_CHECK
  'meditate': {between: [['11am', '4pm'], BEFORE_BED]}
  'read 200 pages of MMTG'
]
