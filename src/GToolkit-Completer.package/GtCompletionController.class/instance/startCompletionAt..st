private - popup
startCompletionAt: aTextIndex
	self terminatePopupDelay.
	
	"If there are no completions for a given index, remove the popup"
	((self strategyAt: aTextIndex) hasCompletionsAt: aTextIndex in: self text)
		ifFalse: [ ^ self removePopup ].

	self isShowingPopup
		ifTrue: [ self updatePopupItemsAt: aTextIndex autoSelect: true ]
		ifFalse: [ self startPopupDelayAt: aTextIndex ]