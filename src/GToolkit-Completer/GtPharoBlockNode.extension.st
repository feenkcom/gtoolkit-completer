Extension { #name : #GtPharoBlockNode }

{ #category : #'*GToolkit-Completer' }
GtPharoBlockNode >> completionActionsFor: aStrategy [
	(aStrategy index between: body startPosition and: body stopPosition)
		ifTrue: [ ^ body completionActionsFor: aStrategy ].
	^ #()
]

{ #category : #'*GToolkit-Completer' }
GtPharoBlockNode >> defines: aString [
	^ variables anySatisfy: [ :each | each name value = aString ]
]

{ #category : #'*GToolkit-Completer' }
GtPharoBlockNode >> guessType: completionStrategy [
	^ [  ] class
]

{ #category : #'*GToolkit-Completer' }
GtPharoBlockNode >> localVariablesInto: aCollection [
	variables do: [ :each | aCollection add: each name value ].
	super localVariablesInto: aCollection
]
