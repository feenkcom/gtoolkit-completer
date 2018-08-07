generated
scanForTokenX1X3
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(17) ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(23) ].
	currentCharacter isDigit
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ])
		ifTrue:
			[ ^ self scanForTokenX1X1 ].
	currentCharacter isSpecial
		ifTrue:
			[ ^ self scanForTokenX1X2 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(4).
			self step.
			currentCharacter == $:
				ifTrue: [ ^ self scan12 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch