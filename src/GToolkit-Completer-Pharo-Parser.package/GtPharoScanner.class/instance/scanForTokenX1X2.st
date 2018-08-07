generated
scanForTokenX1X2
	[ self recordMatch: #(26).
	self step.
	currentCharacter isSpecial ] whileTrue.
	^ self reportLastMatch