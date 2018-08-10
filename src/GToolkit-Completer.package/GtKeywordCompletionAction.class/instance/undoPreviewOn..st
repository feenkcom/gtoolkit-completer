executing
undoPreviewOn: aCompletionController
	aCompletionController textEditor delete: position to: endPosition.
	aCompletionController textEditor cursor position: position