private
parseSource: aString
	^ [ isMethod
		ifTrue: [ GtPharoParser parseWithErrors: aString ]
		ifFalse: [ GtPharoParser parseWithErrors: aString startingAt: GtPharoParser startingStateForMethodSequence ] ]
		on: SmaCCParserError
		do: [ :ex | ex return: nil ]