private - popup
startPopupDelayAt: anIndex
	"Completion delay must already have element: attached,
	see ${method:GtCompletionController>>#textElement:}$"

	completionDelay action: [ self showPopupAt: anIndex ].
	completionDelay start