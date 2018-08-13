executing
undoPreviewOn: aCompletionController
	deletedString isNil
		ifTrue: [ ^ self ].
	aCompletionController textEditor insertString: deletedString at: from - 1