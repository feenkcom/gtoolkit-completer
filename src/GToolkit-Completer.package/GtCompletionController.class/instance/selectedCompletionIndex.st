private-popup
selectedCompletionIndex
	| selection |
	selection := listElement selection.
	^ selection isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ selection from ]