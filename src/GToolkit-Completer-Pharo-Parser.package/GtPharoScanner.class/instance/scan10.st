generated
scan10
	self recordMatch: #(26).
	self step.
	currentCharacter isDigit
		ifTrue: [ ^ self recordAndReportMatch: #(11) ].
	currentCharacter isSpecial
		ifTrue: [ [ self recordMatch: #(26).
			self step.
			currentCharacter isSpecial ] whileTrue ].
	^ self reportLastMatch