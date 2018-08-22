private - popup
showPopupAt: anIndex
	"Show the completion popup selecting the first relevant completion item"

	self updatePopupItemsAt: anIndex autoSelect: true.

	(self isShowingPopup or: [ self completionActions isEmpty ])
		ifTrue: [ ^ self ].

	self
		assert: [ overlay isAttachedToSceneGraph not ]
		description: [ 'Overlay must not be already visible' ]. 

	self
		assert: [ textElement isAttachedToSceneGraph ]
		"otherwise how popup can be opened?"
		description: [ 'Text editor must be in the scene graph' ].

	textElement space root addChild: overlay