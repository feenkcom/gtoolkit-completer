accessing
completionActionsFor: aText at: positionInteger max: maxSize
	| prefix |
	prefix := self completionPrefixAt: positionInteger in: aText.
	(prefix isNil or: [ prefix size < self minimumPrefixLength ])
		ifTrue: [ ^ #() ].
	(self hasCompletionEntryFor: prefix)
		ifFalse: [ ^ #() ].
	^ (self first: maxSize startingWith: prefix)
		collect:
			[ :each | GtInsertTextCompletionAction labeled: each completion: (each allButFirst: prefix size) position: positionInteger ]