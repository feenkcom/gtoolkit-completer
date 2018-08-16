*GToolkit-Completer
completionActionsFor: aStrategy
	| prefix variables |
	self stopPosition = aStrategy index
		ifFalse: [ ^ #() ].
	prefix := name source.
	variables := self localVariables first: aStrategy maxItems startingWith: prefix.
	variables addAll: (aStrategy variables first: aStrategy maxItems - variables size startingWith: prefix).
	^ variables
		collect:
			[ :each | GtInsertTextCompletionAction labeled: each completion: (each allButFirst: prefix size) position: aStrategy index ]