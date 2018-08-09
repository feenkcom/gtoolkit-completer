*GToolkit-Completer
completionActionsFor: aStrategy
	| prefix |
	self stopPosition = aStrategy index
		ifFalse: [ ^ #() ].
	prefix := name source.
	^ (aStrategy variables first: aStrategy maxItems startingWith: prefix)
		collect: [ :each | 
			GtInsertTextCompletionAction
				labeled: each
				completion: (each copyFrom: prefix size + 1 to: each size)
				position: aStrategy index ]