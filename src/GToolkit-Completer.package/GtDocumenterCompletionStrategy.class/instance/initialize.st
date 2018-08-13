initialization
initialize
	super initialize.
	annotationTags := GtPrefixTree new.
	PRAbstractAnnotation
		allSubclassesDo: [ :class | 
			class isAbstract
				ifFalse: [ annotationTags add: '${' , class tag ] ]