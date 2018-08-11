*GToolkit-Completer
localVariablesInto: aCollection
	variables do: [ :each | aCollection add: each name value ].
	super localVariablesInto: aCollection