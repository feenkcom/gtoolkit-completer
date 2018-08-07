generated
scan4
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(8).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan4 ].
			^ self reportLastMatch ].
	true ] whileTrue