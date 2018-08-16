executing
finishCompletionOn: aCompletionController moveCursor: aBoolean
	aBoolean
		ifFalse: [ ^ self ].
	self moveCursorOn: aCompletionController.
	self removeAttributesFromText: aCompletionController text