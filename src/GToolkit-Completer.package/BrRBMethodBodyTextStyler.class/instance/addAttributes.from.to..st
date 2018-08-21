adding
addAttributes: attributes from: start to: stop
	| length |
	length := methodPatternSource size + 1.
	start <= length
		ifTrue: [ ^ self ].
	^ super addAttributes: attributes from: start - length to: stop - length