*GToolkit-Completer
localVariablesInto: aCollection
	parent notNil
		ifTrue: [ parent localVariablesInto: aCollection ]