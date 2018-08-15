event handling
processKeyDown: anEvent
	self isShowingPopup
		ifFalse: [ ^ self ].
	anEvent key = Key escape
		ifTrue: [ self cancelPreview.
			self removePopup.
			anEvent consumed: true ].
	(anEvent key = Key arrowRight and: [ anEvent modifiers isCmd ])
		ifTrue: [ self drillDown.
			anEvent consumed: true ].
	(anEvent key = Key arrowLeft and: [ anEvent modifiers isCmd ])
		ifTrue: [ self undoDrillDown.
			anEvent consumed: true ]