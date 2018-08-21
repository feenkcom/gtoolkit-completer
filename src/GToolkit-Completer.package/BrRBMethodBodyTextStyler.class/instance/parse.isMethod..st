parsing
parse: aText isMethod: isMethod
	| source |
	source := methodPatternSource , ' ' , aText asString.
	^ super parse: source isMethod: true