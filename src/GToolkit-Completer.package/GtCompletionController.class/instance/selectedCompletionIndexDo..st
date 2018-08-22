private - list selection
selectedCompletionIndexDo: aBlock
	"Evaluate a given block with the current selection index if there is one"
	| aSelection |
	
	aSelection := listElement selection.
	aSelection isNotEmpty
		ifTrue: [ aBlock value: aSelection from ]