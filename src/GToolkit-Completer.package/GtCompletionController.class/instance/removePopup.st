private-popup
removePopup
	self terminatePopupDelay.
	self isShowingPopup
		ifFalse: [ ^ self ].
	overlay detach.
	overlay removeFromParent