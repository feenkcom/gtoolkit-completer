generated
scan3
	self step.
	currentCharacter == $#
		ifTrue: [ self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan4 ].
			currentCharacter isSpecial
				ifTrue: [ [ self recordMatch: #(8).
					self step.
					currentCharacter isSpecial ] whileTrue.
					^ self reportLastMatch ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan5 ].
			^ self reportLastMatch ].
	currentCharacter == $'
		ifTrue: [ ^ self scan4 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter isSpecial
		ifTrue: [ [ self recordMatch: #(8).
			self step.
			currentCharacter isSpecial ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch