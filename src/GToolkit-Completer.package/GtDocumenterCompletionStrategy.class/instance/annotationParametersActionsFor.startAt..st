private-annotations
annotationParametersActionsFor: parametersString startAt: parametersStart
	| char |
	(self parameterRegex matchingRangesIn: parametersString)
		do: [ :each | 
			(position between: each first + parametersStart and: each last + parametersStart)
				ifTrue: [ ^ self annotationParameterActionsFor: (parametersString copyFrom: each first to: each last) startAt: parametersStart + each first ] ].
	char := string at: position.
	(':|' includes: char)
		ifTrue: [ ^ self parametersStartingWith: '' delete: 0 includeDefaultValues: true ].
	^ #()