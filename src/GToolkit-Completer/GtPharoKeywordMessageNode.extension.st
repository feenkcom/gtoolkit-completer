Extension { #name : #GtPharoKeywordMessageNode }

{ #category : #'*GToolkit-Completer' }
GtPharoKeywordMessageNode >> messageReceiver [
	^ values last messageReceiver
]
