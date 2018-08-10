event handling
processTabKey: anEvent
	self isShowingPopup
		ifTrue: [ self completeWithCursor: true.
			^ anEvent consumed: true ].
	self isAtStartOfLine
		ifFalse: [ self advanceCursorToNextUncompletedItem
				ifTrue: [ anEvent consumed: true ] ]