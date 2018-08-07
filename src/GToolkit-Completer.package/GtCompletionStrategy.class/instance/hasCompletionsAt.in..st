testing
hasCompletionsAt: anInteger in: aText
	| prefix |
	prefix := self completionPrefixAt: anInteger in: aText.
	prefix isNil
		ifTrue: [ ^ false ].
	^ self hasCompletionEntryFor: prefix