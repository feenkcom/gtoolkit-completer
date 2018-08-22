private - preview
applyPreview

	self
		assert: [ previewAction isNil ]
		"otherwise preview text gets duplicated in the editor"
		description: [ 'Preview can only be applied when there is no active preview action' ].

	self
		ignoreTextEventsWhile: [
			self selectedCompletionItemDo: [ :aCompletionAction |
				previewAction := aCompletionAction.

				GtCompletionApplyPreviewSignal new
					action: previewAction;
					emit.

				previewAction previewOn: self ] ].
	lastWasText := false