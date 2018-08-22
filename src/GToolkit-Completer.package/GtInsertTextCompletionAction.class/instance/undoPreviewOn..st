executing
undoPreviewOn: aCompletionController
	self removeAttributesFromText: aCompletionController text.
	text isEmpty
		ifFalse: [ aCompletionController textEditor delete: position to: position + text size ].
	aCompletionController textEditor moveCursorTo: position