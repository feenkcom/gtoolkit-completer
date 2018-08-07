generated
scan1X7
	[ self recordMatch: #(26).
	self step.
	currentCharacter isSpecial ] whileTrue.
	^ self reportLastMatch