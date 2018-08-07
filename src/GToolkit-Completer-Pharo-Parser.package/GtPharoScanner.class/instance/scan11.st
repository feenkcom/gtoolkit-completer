generated
scan11
	[ self step.
	currentCharacter == $`
		ifTrue: [ self recordMatch: #(32).
			self step.
			currentCharacter == $`
				ifTrue: [ ^ self scan11 ].
			^ self reportLastMatch ].
	true ] whileTrue