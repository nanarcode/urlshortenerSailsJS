Short Unique ID Generator
========================

This module allows you to generate length-efficient unique IDs, that can be used instead of UUID (v4). The generator uses a limited dictionary space of characters and generates IDs of increasing length to allow for Length-Efficient ids as opposed to UUIDs, that always generate IDs of length 36 or 48 from the getgo.

Given a dictionary size of M and an required ID length <= n, the generator has an output space of:

	M + M^2 + M^3 + ... + M^n 		(Number of IDs with length <= n)

This provides very length-efficient IDs even for modest lengths. For example, if you wish to generate IDs of length no greater than 6, then the generator's can output as many as **57,731,386,986 (~57 Billion)** unique ids.

# Installation
	npm install short-uid

# Usage

* Import the module:

		var ShortUID = require('short-uid');
		
* Instantiate Id Generator:

		var idGen = new ShortUID();
		
* Generate Counter-based ID:

		var id = idGen.counterUUID();
		
* Generate Random ID:

		var id = idGen.randomUUID();