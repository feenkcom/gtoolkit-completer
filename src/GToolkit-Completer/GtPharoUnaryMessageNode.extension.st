Extension { #name : #GtPharoUnaryMessageNode }

{ #category : #'*GToolkit-Completer' }
GtPharoUnaryMessageNode >> completionActionsFor: strategy [
	| startingText index |
	index := strategy index.
	selectorPart stopPosition = index
		ifFalse: [ ^ #() ].
	startingText := selectorPart value.
	^ (strategy
		selectorsForReceiver: (parent receiver guessType: strategy)
		matching: startingText)
		collect: [ :each | 
			parent
				actionForSelector: each
				startingWith: startingText
				at: index
				needsParensKeywords: parent parent needsParenthesisForKeyword ]
]

{ #category : #'*GToolkit-Completer' }
GtPharoUnaryMessageNode >> messageReceiver [
	^ parent
]
