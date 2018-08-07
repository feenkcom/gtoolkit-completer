event handling
processKeystroke: anEvent
	self isShowingPopup
		ifFalse: [ ^ self ].
	anEvent char = Character tab
		ifTrue: [ self completeWithCursor: true.
			^ anEvent consumed: true ].
	self cancelPreview.
	anEvent char = Character arrowDown
		ifTrue: [ self selectNextItem.
			anEvent consumed: true ].
	anEvent char = Character arrowUp
		ifTrue: [ self selectPreviousItem.
			anEvent consumed: true ]