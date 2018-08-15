event handling
cursorMoved: anEvent
	(anEvent newIndex = anEvent oldIndex or: [ ignoreTextEvents ])
		ifTrue: [ ^ self ].
	lastWasText
		ifFalse: [ self completeWithCursor: false ].
	lastWasText := false.
	previewAction := nil