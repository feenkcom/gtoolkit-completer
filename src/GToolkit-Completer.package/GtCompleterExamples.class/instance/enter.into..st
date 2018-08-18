private
enter: anArray into: completionController
	anArray
		do: [ :each | 
			each isInteger
				ifTrue: [ self moveCursorTo: each on: completionController ].
			each isString
				ifTrue: [ each isSymbol
						ifTrue: [ self perform: each with: completionController ]
						ifFalse: [ self insertString: each on: completionController ] ].
			each isCharacter
				ifTrue: [ self insertString: (String with: each) on: completionController ].
			each isBlock
				ifTrue: [ each value: completionController ] ]