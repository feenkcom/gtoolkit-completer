initialize-release
initialize
	super initialize.
	isMethod := true.
	hasImplicitVariables := false.
	variables := GtPrefixTree withAll: Smalltalk keys.
	variables addAll: #('self' 'true' 'false' 'nil' 'thisContext')