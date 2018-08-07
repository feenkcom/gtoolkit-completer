event handling
textInserted: anEvent
	ignoreTextChangeEvent
		ifFalse: [ self startCompletionAt: anEvent index + 1 ].
	lastWasText := true