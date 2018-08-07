private-popup
updatePopupItemsAt: anIndex
	| items |
	self cancelPreview.
	items := (self strategyAt: anIndex) completionActionsFor: self text at: anIndex max: MaxPopupItems.
	self completionActions: items.
	self deselectFrom: items size + 1.
	items isEmpty
		ifTrue: [ ^ self removePopup ].
	self applyPreview