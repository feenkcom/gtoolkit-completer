initialize-release
initialize
	super initialize.
	isMethod := true.
	implicitVariables := false.
	variables := GtPrefixTree withAll: Smalltalk keys.
	variables addAll: #('self' 'true' 'false' 'nil' 'thisContext')