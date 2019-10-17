Extension { #name : #GtPharoAssignmentNode }

{ #category : #'*GToolkit-Completer' }
GtPharoAssignmentNode >> messageReceiver [
	leftParens notEmpty
		ifTrue: [ ^ self ].
	^ value messageReceiver
]
