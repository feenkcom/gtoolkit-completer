private
drillDown
	previewAction isNil
		ifTrue: [ ^ self ].
	self
		ignoreTextEventsWhile: [ drillDownActions addLast: previewAction.
			previewAction drillDownOn: self.
			previewAction := nil.
			self deselectAll.
			self updatePopupItemsAt: self position ]