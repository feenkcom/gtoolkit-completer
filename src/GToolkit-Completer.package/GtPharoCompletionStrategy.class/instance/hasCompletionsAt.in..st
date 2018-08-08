testing
hasCompletionsAt: anInteger in: aText
	| char |
	char := aText at: anInteger.
	^ char isLetter or: [ char isDigit ]