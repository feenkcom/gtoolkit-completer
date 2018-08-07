executing
finishCompletionOn: aCompletionController moveCursor: aBoolean
	aBoolean
		ifFalse: [ ^ self ].
	aCompletionController textEditor moveCursorTo: position + text size