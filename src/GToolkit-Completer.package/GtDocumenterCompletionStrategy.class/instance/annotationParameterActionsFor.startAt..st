private-annotations
annotationParameterActionsFor: parameterString startAt: parameterStart
	self parameterRegex
		matchesIn: parameterString
		subexpressionsDo: [ :str :parts | 
			| name value |
			name := parts first.
			value := parts last.
			name isNil
				ifTrue: [ name := value.
					value := '' ].
			^ (position between: parameterStart and: parameterStart + name size - 1)
				ifTrue: [ self
						parametersStartingWith: (name first: position - parameterStart + 1)
						delete:
							((name includes: $=)
								ifTrue: [ parameterStart + name size - 1 - position ]
								ifFalse: [ 0 ])
						includeDefaultValues: (name includes: $=) not ]
				ifFalse: [ self
						parameterValueActionsForClass: self annotationClass
						name: (name copyWithout: $=)
						startingWith: (value first: position - parameterStart + name size - 1) ] ].
	^ #()