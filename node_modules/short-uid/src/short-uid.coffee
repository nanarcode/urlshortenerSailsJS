###
  Short Unique Id Generator
###

class ShortUID
  # This provides collision-space of ~57B
  DEFAULT_RANDOM_ID_LEN = 6

  # ID Generator Dictionary
  # currently uses only alphabets and digits
  DICT_RANGES =
    digits: [48, 58]
    lowerCase: [97, 123]
    upperCase: [65, 91]

  # Generate Dictionary
  dict = []
  for rangeType, dictRange of DICT_RANGES
    [lowerBound, upperBound] = dictRange
    for dictIndex in [lowerBound ... upperBound]
      dict.push String.fromCharCode(dictIndex)

  # Shuffle Dictionary for removing selection bias
  dict = dict.sort (a, b) -> return Math.random() <= 0.5

  # Cache Dictionary Length for future usage
  dictLength = dict.length

  # Resets internal counter
  # Passing options.debug=true will enable logging
  constructor: (options = {}) ->
    @counter = 0
    @debug = options.debug
    @log "Generator created with Dictionary Size #{dictLength}"

  # Logging is optionally enabled by passing `debug=true` during instantiation
  log: ->
    arguments[0] = "[frugal-id] #{arguments[0]}"
    if @debug is true
      console?.log?.apply(console, arguments)

  # Returns generator's internal dictionary
  getDict: ->
    return dict

  # Generates UUID based on internal counter
  # that's incremented after each ID generation
  counterUUID: ->
    id = ''
    counterDiv = @counter

    # Convert internal counter to Base of internal Dictionary
    while true
      counterRem = counterDiv % dictLength
      counterDiv = parseInt(counterDiv / dictLength)
      id += dict[counterRem]
      break if counterDiv is 0

    # Increment internal counter
    @counter++

    # Return generated ID
    return id

  # Generates UUID by creating each part randomly
  randomUUID: (uuidLength = DEFAULT_RANDOM_ID_LEN) ->
    if not uuidLength? or uuidLength < 1
      throw new Error "Invalid UUID Length Provided"

    # Generate random ID parts from Dictionary
    id = ''
    for idIndex in [0 ... uuidLength]
      randomPartIdx = parseInt(Math.random() * dictLength) % dictLength
      id += dict[randomPartIdx]

    # Return random generated ID
    return id

###
  Export Module
###

if window?
  window.ShortUID = ShortUID
else if exports?
  module.exports = ShortUID