executing
finishCompletionOn: aCompletionController moveCursor: aBoolean
	self removeAttributesFromText: aCompletionController text.
	aBoolean
		ifFalse: [ ^ self ].
	self moveCursorOn: aCompletionController