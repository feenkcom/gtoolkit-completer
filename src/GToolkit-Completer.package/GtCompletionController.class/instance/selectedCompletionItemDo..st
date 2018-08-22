private - list selection
selectedCompletionItemDo: aBlock
	"Evaluate a given block with the currently selected completion item if there is one"
	
	self selectedCompletionIndexDo: [ :anIndex |
		aBlock value: (self completionActions at: anIndex) ]