*GToolkit-Completer
localVariables
	| variables |
	variables := GtPrefixTree new.
	self localVariablesInto: variables.
	^ variables