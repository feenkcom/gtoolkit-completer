private
undoDrillDown
	drillDownActions isEmpty
		ifTrue: [ ^ false ].
	self
		ignoreTextEventsWhile: [ | action |
			previewAction notNil
				ifTrue: [ self cancelPreview ].
			action := drillDownActions removeLast.
			action undoDrillDownOn: self.
			previewAction := action.
			self deselectAll.
			self updatePopupItemsAt: self position.
			self selectAction: action.
			self applyPreview ]