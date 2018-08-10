private-popup
showPopupAt: anIndex
	self updatePopupItemsAt: anIndex.
	(self isShowingPopup or: [ self completionActions isEmpty ])
		ifTrue: [ ^ self ].
	listElement background: Color white.
	self deselectAll.
	cursorElement ifNotNil: [
		overlay geometry: (BlRectangle extent: 100 @ 50).
		overlay attachTo: cursorElement.
		textElement parent addChild: overlay ]