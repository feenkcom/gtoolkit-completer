private
applyPreview
	self
		ignoreTextEventsWhile: [ previewAction := self selectedCompletionItem.
			previewAction notNil
				ifTrue: [ previewAction previewOn: self ] ].
	lastWasText := false