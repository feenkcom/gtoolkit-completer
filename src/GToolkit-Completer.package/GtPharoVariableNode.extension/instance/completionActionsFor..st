*GToolkit-Completer
completionActionsFor: aStrategy
	| prefix variables allLocalVariables |
	self stopPosition = aStrategy index
		ifFalse: [ ^ #() ].
	prefix := name source.
	allLocalVariables := aStrategy hasImplicitVariables
		ifTrue: [ self implicitLocalVariables ]
		ifFalse: [ self localVariables ].
	variables := allLocalVariables first: aStrategy maxItems startingWith: prefix.
	variables addAll: (aStrategy variables first: aStrategy maxItems - variables size startingWith: prefix).
	^ variables
		collect: [ :each | GtInsertTextCompletionAction labeled: each completion: (each allButFirst: prefix size) position: aStrategy index ]