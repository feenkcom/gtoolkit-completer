testing
hasCompletionsAt: anInteger in: aText
	| char |
	anInteger < 1
		ifTrue: [ ^ false ].
	char := aText at: anInteger.
	^ char isLetter or: [ char isDigit ]