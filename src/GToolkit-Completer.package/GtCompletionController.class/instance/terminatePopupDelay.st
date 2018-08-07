private-popup
terminatePopupDelay
	completionDelay notNil
		ifTrue: [ completionDelay terminate.
			completionDelay := nil ]