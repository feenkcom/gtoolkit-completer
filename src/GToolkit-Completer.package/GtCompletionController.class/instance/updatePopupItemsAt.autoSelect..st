private-popup
updatePopupItemsAt: anIndex autoSelect: aBoolean
	| items |
	self cancelPreview.
	items := [ (self strategyAt: anIndex) completionActionsFor: self text at: anIndex max: MaxPopupItems ]
		on: Error
		do: [ :ex | ex return: #() ].
	self completionActions: items.
	self deselectAll.
	aBoolean
		ifFalse: [ ^ self ].
	items isEmpty
		ifTrue: [ ^ self removePopup ].
	self selectIndex: 1.
	self applyPreview