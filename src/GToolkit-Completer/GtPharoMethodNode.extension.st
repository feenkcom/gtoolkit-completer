Extension { #name : #GtPharoMethodNode }

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
