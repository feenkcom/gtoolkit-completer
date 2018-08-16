executing
undoPreviewOn: aCompletionController
	self removeAttributesFromText: aCompletionController text.
	parenIndex notNil
		ifTrue: [ aCompletionController textEditor delete: parenIndex - 1 to: parenIndex ].
	aCompletionController textEditor delete: position to: endPosition.
	aCompletionController textEditor cursor position: position