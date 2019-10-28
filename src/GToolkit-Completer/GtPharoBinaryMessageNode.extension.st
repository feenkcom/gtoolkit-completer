Extension { #name : #GtPharoBinaryMessageNode }

{ #category : #'*GToolkit-Completer' }
GtPharoBinaryMessageNode >> completionActionsFor: strategy [
	| startingText index |
	index := strategy index.
	selectorPart stopPosition = index
		ifFalse: [ ^ super completionActionsFor: strategy ].
	startingText := selectorPart value.
	^ (strategy
		selectorsForReceiver: (parent receiver guessType: strategy)
		matching: startingText)
		collect: [ :each | 
			parent
				actionForSelector: each
				startingWith: startingText
				at: index
				needsParensKeywords:
					((value isKindOf: GtPharoErrorNode)
						ifTrue: [ parent parent ]
						ifFalse: [ parent ]) needsParenthesisForKeyword ]
]

{ #category : #'*GToolkit-Completer' }
GtPharoBinaryMessageNode >> messageReceiver [
	^ value messageReceiver
]
