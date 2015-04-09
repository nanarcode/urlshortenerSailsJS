Assert = require 'assert'
ShortUID = require 'src/short-uid'


describe 'Short UID Generator', ->
  nanotime = -> process.hrtime()[1]
  gen = new ShortUID(debug: false)

  describe 'Generator', ->
    it 'should initialize', ->
      Assert.ok(gen)

    it 'should have large dictionary', ->
      Assert.equal(gen.getDict().length, 62)

    it 'should generate Random IDs', ->
      id = gen.randomUUID()
      Assert.ok(id)

    it 'should generate Counter IDs', ->
      id = gen.counterUUID()
      Assert.ok(id)

  describe 'Random UUID Generator', ->
    it 'should guarantee randomness', ->
      pastGenIds = {}
      for i in [0 ... Math.pow(62, 3)]
        id = gen.randomUUID()
        Assert.ok not pastGenIds[id], "Collision Detected after #{i} iterations with ID #{id}"
        pastGenIds[id] = true

    it 'should generate ID with default length', ->
      id = gen.randomUUID()
      Assert.ok(id.length > 1)

    it 'should allow generating ID with custom length', ->
      id = gen.randomUUID(10)
      Assert.equal(id.length, 10, "ID (#{id}) Length is Invalid")

    it 'should generate in a few μs', ->
      genStartTime = nanotime()
      id = gen.randomUUID()
      genEndTime = nanotime()
      genNanoDuration = genEndTime - genStartTime
      Assert.ok genNanoDuration < 50000, "ID generated in #{genNanoDuration} ns isn't quick enough"

  describe 'Counter UUID Generator', ->
    it 'should not have collisions', ->
      pastGenIds = {}
      for i in [0 ... Math.pow(62, 3)]
        id = gen.counterUUID()
        Assert.ok (not pastGenIds[id]?), "Collision Detected after #{i} iterations with ID #{id}"
        pastGenIds[id] = true

    it 'should generate in a few μs', ->
      genStartTime = nanotime()
      id = gen.counterUUID()
      genEndTime = nanotime()
      genNanoDuration = genEndTime - genStartTime
      Assert.ok genNanoDuration < 50000, "ID generated in #{genNanoDuration} ns isn't quick enough"
