event handling
processPopupKeystroke: anEvent
	self isShowingPopup
		ifFalse: [ ^ self ].
	anEvent char = Character tab
		ifTrue: [ self completeWithCursor: true.
			textElement requestFocus.
			^ anEvent consumed: true ]