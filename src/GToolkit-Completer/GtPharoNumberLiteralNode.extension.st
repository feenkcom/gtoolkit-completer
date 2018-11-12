Extension { #name : #GtPharoNumberLiteralNode }

{ #category : #'*GToolkit-Completer' }
GtPharoNumberLiteralNode >> guessType: completionStrategy [
	^ [ (Number readFrom: value source) class ]
		on: Error
		do: [ :ex | ex return: Number ]
]
