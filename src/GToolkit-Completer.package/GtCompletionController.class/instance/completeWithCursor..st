private
completeWithCursor: aBoolean
	self
		ignoreTextEventsWhile: [ | partial |
			partial := false.
			previewAction notNil
				ifTrue: [ partial := previewAction isPartial.
					previewAction finishCompletionOn: self moveCursor: aBoolean.
					self resetActions ].
			self deselectAll.
			partial
				ifTrue: [ self updatePopupItemsAt: self position ]
				ifFalse: [ self removePopup ] ]