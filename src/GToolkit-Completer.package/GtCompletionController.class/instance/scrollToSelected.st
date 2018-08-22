private - list selection
scrollToSelected
	self selectedCompletionIndexDo: [ :anIndex | self scrollTo: anIndex ]