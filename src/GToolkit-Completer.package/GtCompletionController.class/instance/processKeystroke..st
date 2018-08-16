event handling
processKeystroke: anEvent
	anEvent char = Character tab
		ifTrue: [ ^ self processTabKey: anEvent ].
	self isShowingPopup
		ifFalse: [ ^ self ].
	anEvent char = Character cr
		ifTrue: [ ^ self processReturnKey: anEvent ].
	self cancelPreview.
	anEvent char = Character arrowDown
		ifTrue: [ self selectNextItem.
			anEvent consumed: true ].
	anEvent char = Character arrowUp
		ifTrue: [ self selectPreviousItem.
			anEvent consumed: true ]