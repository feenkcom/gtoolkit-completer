*GToolkit-Completer
localVariablesInto: aCollection
	self variables do: [ :each | aCollection add: each name value ]