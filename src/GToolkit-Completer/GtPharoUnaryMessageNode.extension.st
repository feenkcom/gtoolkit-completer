Extension { #name : #GtPharoUnaryMessageNode }

{ #category : #'*GToolkit-Completer' }
GtPharoUnaryMessageNode >> completionActionsFor: strategy [
	| startingText index |
	index := strategy index.
	selectorPart stopPosition = index
		ifFalse: [ ^ #() ].
	startingText := selectorPart value.
	^ (strategy selectorsForReceiver: (parent receiver guessType: strategy) matching: startingText)
		collect: [ :each | self actionForSelector: each startingWith: startingText at: index ]
]

{ #category : #'*GToolkit-Completer' }
GtPharoUnaryMessageNode >> needsParenthesisForKeyword [
	| messageSendParent |
	messageSendParent := parent parent.
	^ (messageSendParent isKindOf: GtPharoMessageNode)
		or: [ (messageSendParent isKindOf: GtPharoMessageSendNode) or: [ messageSendParent isKindOf: GtPharoCascadeNode ] ]
]
