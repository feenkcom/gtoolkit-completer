Extension { #name : #GtPharoNumberLiteralNode }

{ #category : #'*GToolkit-Completer' }
GtPharoNumberLiteralNode >> guessType: aClass [
	^ [ (Number readFrom: value source) class ]
		on: Error
		do: [ :ex | ex return: Number ]
]
