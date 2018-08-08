private
addVariableActionsFor: variableNode at: anInteger to: actions
	| prefix |
	variableNode stopPosition = anInteger
		ifFalse: [ ^ self ].
	prefix := variableNode name source.
	(variables first: max startingWith: prefix)
		do: [ :each | actions add: (GtInsertTextCompletionAction labeled: each completion: (each copyFrom: prefix size + 1 to: each size) position: anInteger) ]