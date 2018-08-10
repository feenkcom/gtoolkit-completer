executing
finishCompletionOn: aCompletionController moveCursor: aBoolean
	aBoolean
		ifFalse: [ ^ self ].
	aCompletionController advanceCursorToNextUncompletedItem