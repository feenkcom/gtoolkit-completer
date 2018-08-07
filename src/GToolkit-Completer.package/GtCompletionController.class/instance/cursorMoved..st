event handling
cursorMoved: anEvent
	lastWasText
		ifFalse: [ self completeWithCursor: false ].
	lastWasText := false.
	previewAction := nil