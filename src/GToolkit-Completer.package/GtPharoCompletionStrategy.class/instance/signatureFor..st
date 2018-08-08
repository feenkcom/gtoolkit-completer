private-method
signatureFor: aMethod
	| source ast |
	source := aMethod sourceCode.
	ast := GtPharoParser parse: source.
	^ source
		copyFrom: ast selectorParts first startPosition
		to:
			(ast variables isEmpty
				ifTrue: [ ast selectorParts ]
				ifFalse: [ ast variables ]) last stopPosition