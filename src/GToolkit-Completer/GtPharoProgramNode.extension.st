Extension { #name : #GtPharoProgramNode }

{ #category : #'*GToolkit-Completer' }
GtPharoProgramNode >> completionActionsFor: aGtPharoCompletionStrategy [
	^ #()
]

{ #category : #'*GToolkit-Completer' }
GtPharoProgramNode >> defines: aString [
	^ false
]

{ #category : #'*GToolkit-Completer' }
GtPharoProgramNode >> implicitLocalVariables [
	| variables |
	variables := self localVariables.
	self topParent
		allNodesOfType: GtPharoVariableNode
		do: [ :each | 
			(each == self or: [ each isLocallyDefined ])
				ifFalse: [ variables add: each name value ] ].
	^ variables
]

{ #category : #'*GToolkit-Completer' }
GtPharoProgramNode >> localVariables [
	| variables |
	variables := GtPrefixTree new.
	self localVariablesInto: variables.
	^ variables
]

{ #category : #'*GToolkit-Completer' }
GtPharoProgramNode >> localVariablesInto: aCollection [
	parent notNil
		ifTrue: [ parent localVariablesInto: aCollection ]
]
