private-popup
selectedCompletionItem
	| index |
	index := self selectedCompletionIndex.
	index = 0
		ifTrue: [ ^ nil ].
	^ listElement viewModel items at: index