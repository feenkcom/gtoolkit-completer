Extension { #name : #GtPharoMethodNode }

{ #category : #'*GToolkit-Completer' }
GtPharoMethodNode >> completionActionsFor: aStrategy [
	((self comments ifNil: [ #() ])
		anySatisfy: [ :each | aStrategy index between: each first and: each last ])
		ifTrue: [ ^ #() ].
	aStrategy index > pattern stopPosition
		ifTrue: [ ^ body completionActionsFor: aStrategy ].
	^ super completionActionsFor: aStrategy
]

{ #category : #'*GToolkit-Completer' }
GtPharoMethodNode >> defines: aString [
	^ self variables anySatisfy: [ :each | each name value = aString ]
]

{ #category : #'*GToolkit-Completer' }
GtPharoMethodNode >> localVariablesInto: aCollection [
	self variables do: [ :each | aCollection add: each name value ]
]

{ #category : #'*GToolkit-Completer' }
GtPharoMethodNode >> selectorParts [
	^ pattern selectorParts
]

{ #category : #'*GToolkit-Completer' }
GtPharoMethodNode >> variables [
	^ pattern variables
]
