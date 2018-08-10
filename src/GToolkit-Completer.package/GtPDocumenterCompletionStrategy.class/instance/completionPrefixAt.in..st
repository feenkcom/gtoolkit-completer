accessing
completionPrefixAt: positionInteger in: aText
	| startIndex char |
	positionInteger < 1
		ifTrue: [ ^ nil ].
	startIndex := positionInteger.
	[ char := aText at: startIndex.
	char = $$ or: [ char isSeparator or: [ startIndex = 1 ] ] ] whileFalse: [ startIndex := startIndex - 1 ].
	^ char = $$
		ifTrue: [ (aText from: startIndex to: positionInteger) asString ]
		ifFalse: [ nil ]