private
cancelPreview
	previewAction isNil
		ifTrue: [ ^ self ].
	self
		ignoreTextEventsWhile: [ previewAction undoPreviewOn: self.
			previewAction := nil ]