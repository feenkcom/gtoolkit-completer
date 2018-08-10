*GToolkit-Completer
completionActionsFor: strategy
	| startingText index |
	index := strategy index.
	selectorPart stopPosition = index
		ifFalse: [ ^ #() ].
	startingText := selectorPart value.
	^ (strategy selectorsForReceiver: (parent receiver guessType: strategy classOrMetaClass) matching: startingText)
		collect: [ :each | self actionForSelector: each startingWith: startingText at: index ]