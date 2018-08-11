private
addParenthesesOn: aCompletionController
	parenIndex isNil
		ifTrue: [ ^ self ].
	aCompletionController textEditor insertString: ')' at: endPosition.
	endPosition := endPosition + 1.
	aCompletionController textEditor insertString: '(' at: parenIndex - 1