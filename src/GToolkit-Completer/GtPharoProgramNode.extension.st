Extension { #name : #GtPharoProgramNode }

{ #category : #'*GToolkit-Completer' }
GtPharoProgramNode >> actionForSelector: aSymbol startingWith: aString at: anInteger needsParensKeywords: aBoolean [
	| isKeyword isBinary actionClass action |
	isKeyword := aSymbol last = $:.
	isBinary := aSymbol asSymbol isBinary.
	actionClass := isKeyword
		ifTrue: [ GtKeywordCompletionAction ]
		ifFalse: [ isBinary
				ifTrue: [ GtBinaryCompletionAction ]
				ifFalse: [ GtInsertTextCompletionAction ] ].
	action := actionClass
		labeled: aSymbol
		completion: (aSymbol allButFirst: aString size)
		position: anInteger.
	((isKeyword or: [ isBinary ]) and: [ aBoolean ])
		ifTrue: [ action addParenthesesBefore: self startPosition ].
	^ action
]

{ #category : #'*GToolkit-Completer' }
GtPharoProgramNode >> completionActionsFor: aStrategy [
	((self comments ifNil: [ #() ])
		anySatisfy: [ :each | aStrategy index between: each first and: each last ])
		ifTrue: [ ^ #() ].
	self
		nodesDo: [ :each | 
			(aStrategy index between: each startPosition and: each stopPosition)
				ifTrue: [ ^ each completionActionsFor: aStrategy ] ].
	^ #()
]

{ #category : #'*GToolkit-Completer' }
GtPharoProgramNode >> defines: aString [
	^ false
]

{ #category : #'*GToolkit-Completer' }
GtPharoProgramNode >> messageReceiver [
	^ self
]

{ #category : #'*GToolkit-Completer' }
GtPharoProgramNode >> needsParenthesisForKeyword [
	^ false
]
