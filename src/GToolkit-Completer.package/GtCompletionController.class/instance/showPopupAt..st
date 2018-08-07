private-popup
showPopupAt: anIndex
	self updatePopupItemsAt: anIndex.
	(self isShowingPopup or: [ self completionActions isEmpty ])
		ifTrue: [ ^ self ].
	listElement background: Color white.
	self deselectAll.
	overlay geometry: (BlRectangle extent: 100 @ 50).
	overlay attachTo: textElement.
	textElement parent addChild: overlay