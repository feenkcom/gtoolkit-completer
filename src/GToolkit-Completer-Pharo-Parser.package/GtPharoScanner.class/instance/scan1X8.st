generated
scan1X8
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(16) ].
	currentCharacter == $|
		ifTrue:
			[ ^ self scan1X4 ].
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(24) ].
	currentCharacter isDigit
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ])
		ifTrue:
			[ ^ self scan1X1 ].
	currentCharacter isSpecial
		ifTrue:
			[ ^ self scan1X7 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(4).
			self step.
			currentCharacter == $:
				ifTrue:
					[ ^ self scan1X2 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch