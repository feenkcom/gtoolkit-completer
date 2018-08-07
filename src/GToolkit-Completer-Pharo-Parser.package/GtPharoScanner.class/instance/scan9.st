generated
scan9
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(7).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan9 ].
			^ self reportLastMatch ].
	true ] whileTrue