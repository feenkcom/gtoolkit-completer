*GToolkit-Completer
actionForSelector: aSymbol startingWith: aString at: anInteger
	^ (aSymbol last = $:
		ifTrue: [ GtKeywordCompletionAction ]
		ifFalse: [ GtInsertTextCompletionAction ])
		labeled: aSymbol
		completion: (aSymbol copyFrom: aString size + 1 to: aSymbol size)
		position: anInteger