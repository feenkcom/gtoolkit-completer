accessing
completionActionsFor: aText at: positionInteger max: maxInteger
	maxItems := maxInteger.
	index := positionInteger.
	^ (self parseSource: aText asString) ifNil: [ #() ] ifNotNil: [ :tree | self actionsFor: tree at: positionInteger ]