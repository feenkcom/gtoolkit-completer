private-popup
startPopupDelayAt: anIndex
	completionDelay := [ (Delay forMilliseconds: self class popupDelayMilliseconds) wait.
	UIManager default defer: [ self showPopupAt: anIndex ].
	completionDelay := nil ] fork