private-annotations
annotationActionsIn: aString startAt: annotationStart
	self annotationRegex
		matchesIn: aString
		subexpressionsDo: [ :str :parts | 
			| tag |
			tag := parts first.
			(position between: annotationStart and: annotationStart + tag size - 1)
				ifTrue: [ ^ self annotationTagActionsFor: tag startAt: annotationStart ].
			(parts at: 3)
				ifNotNil: [ :params | 
					tagName := parts at: 2.
					^ self annotationParametersActionsFor: params startAt: annotationStart + tag size - 1 ] ].
	^ #()