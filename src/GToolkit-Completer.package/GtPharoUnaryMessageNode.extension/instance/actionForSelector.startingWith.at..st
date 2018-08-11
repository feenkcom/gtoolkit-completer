*GToolkit-Completer
actionForSelector: aSymbol startingWith: aString at: anInteger
	| isKeyword actionClass action |
	isKeyword := aSymbol last = $:.
	actionClass := isKeyword
		ifTrue: [ GtKeywordCompletionAction ]
		ifFalse: [ GtInsertTextCompletionAction ].
	action := actionClass labeled: aSymbol completion: (aSymbol copyFrom: aString size + 1 to: aSymbol size) position: anInteger.
	(isKeyword and: [ self needsParenthesisForKeyword ])
		ifTrue: [ action addParenthesesBefore: parent receiver startPosition ].
	^ action