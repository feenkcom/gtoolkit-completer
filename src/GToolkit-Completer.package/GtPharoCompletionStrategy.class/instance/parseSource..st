private
parseSource: aString
	^ [ GtPharoParser parseWithErrors: aString ]
		on: SmaCCParserError
		do: [ :ex | ex return: nil ]