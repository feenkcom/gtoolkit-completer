initialize-release
initialize
	super initialize.
	variables := GtPrefixTree withAll: Smalltalk keys.
	variables addAll: #('self' 'true' 'false' 'nil' 'thisContext')