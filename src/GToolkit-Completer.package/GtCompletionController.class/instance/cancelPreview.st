private - preview
cancelPreview
	previewAction
		ifNil: [ ^ self ].

	self
		ignoreTextEventsWhile: [
			GtCompletionCancelPreviewSignal new
					action: previewAction;
					emit.
			
			previewAction undoPreviewOn: self.
			previewAction := nil ]