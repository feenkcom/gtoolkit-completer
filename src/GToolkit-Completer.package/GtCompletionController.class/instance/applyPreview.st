private
applyPreview
	ignoreTextChangeEvent := true.
	[ previewAction := self selectedCompletionItem.
	previewAction notNil
		ifTrue: [ previewAction previewOn: self ] ]
		ensure: [ ignoreTextChangeEvent := false ].
	lastWasText := false