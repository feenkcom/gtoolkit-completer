Extension { #name : #GtPharoMessageSendNode }

{ #category : #'*GToolkit-Completer' }
GtPharoMessageSendNode >> messageReceiver [
	leftParens notEmpty
		ifTrue: [ ^ self ].
	^ message messageReceiver
]

{ #category : #'*GToolkit-Completer' }
GtPharoMessageSendNode >> needsParenthesisForKeyword [
	^ true
]
