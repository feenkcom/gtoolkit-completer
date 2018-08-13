executing
previewOn: aCompletionController
	from > to
		ifTrue: [ ^ self ].
	deletedString := (aCompletionController text from: from to: to) asString.
	aCompletionController textEditor delete: from - 1 to: to