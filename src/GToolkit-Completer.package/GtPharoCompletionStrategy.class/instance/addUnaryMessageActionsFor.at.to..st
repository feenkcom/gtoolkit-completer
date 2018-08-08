private-selector
addUnaryMessageActionsFor: messageNode at: anInteger to: actions
	| startingText |
	messageNode selectorPart stopPosition = anInteger
		ifFalse: [ ^ false ].
	startingText := messageNode selectorPart value.
	(self selectorsForReceiver: messageNode parent receiver matching: startingText)
		do:
			[ :each | actions add: (GtInsertTextCompletionAction labeled: each completion: (each copyFrom: startingText size + 1 to: each size) position: anInteger) ]