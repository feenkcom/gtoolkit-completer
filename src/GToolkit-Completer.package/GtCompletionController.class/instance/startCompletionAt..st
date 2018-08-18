private
startCompletionAt: anInteger
	self terminatePopupDelay.
	((self strategyAt: anInteger) hasCompletionsAt: anInteger in: self text)
		ifTrue: [ ^ self isShowingPopup
				ifTrue: [ self updatePopupItemsAt: anInteger autoSelect: true ]
				ifFalse: [ self startPopupDelayAt: anInteger ] ].
	self removePopup