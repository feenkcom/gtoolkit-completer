generated
scan5
	[ self recordMatch: #(8).
	self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(8).
			self step.
			currentCharacter == $:
				ifTrue: [ ^ self scan6 ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan7 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue.
	^ self reportLastMatch