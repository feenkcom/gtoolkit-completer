executing
previewOn: aCompletionController
	text isEmpty
		ifTrue: [ ^ self ].
	aCompletionController textEditor insertString: text at: position