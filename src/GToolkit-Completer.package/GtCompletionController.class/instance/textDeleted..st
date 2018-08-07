event handling
textDeleted: anEvent
	ignoreTextChangeEvent
		ifFalse: [ self startCompletionAt: anEvent fromIndex - 1 ].
	lastWasText := true