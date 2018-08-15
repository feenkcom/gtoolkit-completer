event handling
textInserted: anEvent
	ignoreTextEvents
		ifFalse: [ self startCompletionAt: anEvent index + 1 ].
	lastWasText := true