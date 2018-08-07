private
cancelPreview
	previewAction isNil
		ifTrue: [ ^ self ].
	ignoreTextChangeEvent := true.
	[ previewAction undoPreviewOn: self.
	previewAction := nil ]
		ensure: [ ignoreTextChangeEvent := false ]