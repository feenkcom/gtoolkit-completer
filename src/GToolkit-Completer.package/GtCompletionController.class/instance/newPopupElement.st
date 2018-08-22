private - instance creation
newPopupElement
	^ GtCompletionPopupElement new
		layout: BlLinearLayout vertical;
		background: Color red;
		constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal exact: 200 ]