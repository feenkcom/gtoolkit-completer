private
completeWithCursor: aBoolean
	previewAction notNil
		ifTrue: [ previewAction finishCompletionOn: self moveCursor: aBoolean.
			previewAction := nil ].
	self deselectAll.
	self removePopup