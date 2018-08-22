private
drillDown
	previewAction
		ifNil: [ ^ self ].
	
	self
		ignoreTextEventsWhile: [
			drillDownActions addLast: previewAction.
			previewAction drillDownOn: self.
			previewAction := nil.
			self updatePopupItemsAt: self position autoSelect: true ]