Extension { #name : #GtPharoSequenceNode }

{ #category : #'*GToolkit-Completer' }
GtPharoSequenceNode >> defines: aString [
	^ variables anySatisfy: [ :each | each name value = aString ]
]

{ #category : #'*GToolkit-Completer' }
GtPharoSequenceNode >> localVariablesInto: aCollection [
	variables do: [ :each | aCollection add: each name value ].
	super localVariablesInto: aCollection
]
