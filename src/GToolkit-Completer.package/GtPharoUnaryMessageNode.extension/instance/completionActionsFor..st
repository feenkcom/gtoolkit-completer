*GToolkit-Completer
completionActionsFor: strategy
	| startingText |
	selectorPart stopPosition = strategy index
		ifFalse: [ ^ #() ].
	startingText := selectorPart value.
	^ (strategy
		selectorsForReceiver: (parent receiver guessType: nil)
		matching: startingText)
		collect: [ :each | 
			GtInsertTextCompletionAction
				labeled: each
				completion: (each copyFrom: startingText size + 1 to: each size)
				position: strategy index ]