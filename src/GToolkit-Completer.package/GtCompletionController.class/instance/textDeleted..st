event handling
textDeleted: anEvent
	ignoreTextEvents
		ifFalse: [ self startCompletionAt: anEvent fromIndex - 1 ].
	lastWasText := true