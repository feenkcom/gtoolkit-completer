Extension { #name : #GtPharoUnaryMessageNode }

{ #category : #'*GToolkit-Completer' }
GtPharoUnaryMessageNode >> actionForSelector: aSymbol startingWith: aString at: anInteger [
	| isKeyword actionClass action |
	isKeyword := aSymbol last = $:.
	actionClass := isKeyword
		ifTrue: [ GtKeywordCompletionAction ]
		ifFalse: [ GtInsertTextCompletionAction ].
	action := actionClass labeled: aSymbol completion: (aSymbol allButFirst: aString size) position: anInteger.
	(isKeyword and: [ self needsParenthesisForKeyword ])
		ifTrue: [ action addParenthesesBefore: parent receiver startPosition ].
	^ action
]

{ #category : #'*GToolkit-Completer' }
GtPharoUnaryMessageNode >> completionActionsFor: strategy [
	| startingText index |
	index := strategy index.
	selectorPart stopPosition = index
		ifFalse: [ ^ #() ].
	startingText := selectorPart value.
	^ (strategy selectorsForReceiver: (parent receiver guessType: strategy classOrMetaClass) matching: startingText)
		collect: [ :each | self actionForSelector: each startingWith: startingText at: index ]
]

{ #category : #'*GToolkit-Completer' }
GtPharoUnaryMessageNode >> needsParenthesisForKeyword [
	| messageSendParent |
	messageSendParent := parent parent.
	^ (messageSendParent isKindOf: GtPharoMessageNode)
		or: [ (messageSendParent isKindOf: GtPharoMessageSendNode) or: [ messageSendParent isKindOf: GtPharoCascadeNode ] ]
]
