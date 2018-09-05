Extension { #name : #GtPharoVariableNode }

{ #category : #'*GToolkit-Completer' }
GtPharoVariableNode >> completionActionsFor: aStrategy [
	| prefix variables allLocalVariables |
	self stopPosition = aStrategy index
		ifFalse: [ ^ #() ].
	prefix := name source.
	allLocalVariables := aStrategy hasImplicitVariables
		ifTrue: [ self implicitLocalVariables ]
		ifFalse: [ self localVariables ].
	variables := allLocalVariables first: aStrategy maxItems startingWith: prefix.
	variables addAll: (aStrategy variables first: aStrategy maxItems - variables size startingWith: prefix).
	^ variables
		collect: [ :each | GtInsertTextCompletionAction labeled: each completion: (each allButFirst: prefix size) position: aStrategy index ]
]

{ #category : #'*GToolkit-Completer' }
GtPharoVariableNode >> guessType: aClass [
	name value = 'self'
		ifTrue: [ ^ aClass ].
	name value = 'super'
		ifTrue: [ ^ aClass superclass ].
	^ super guessType: aClass
]

{ #category : #'*GToolkit-Completer' }
GtPharoVariableNode >> isLocallyDefined [
	^ self allParents anySatisfy: [ :each | each defines: name value ]
]

{ #category : #'*GToolkit-Completer' }
GtPharoVariableNode >> whoDefines [
	^ self allParents detect: [ :each | each defines: name value ] ifNone: [  ]
]
