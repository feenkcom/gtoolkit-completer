private-annotations
parameterValueActionsForClass: class name: parameterName startingWith: aString
	| selector |
	selector := (ParameterValueCompletionSelectors at: class ifAbsent: [ Dictionary new ]) at: parameterName asSymbol ifAbsent: [ nil ].
	selector notNil
		ifTrue: [ ^ self perform: selector with: aString ].
	^ #()