accessing
completionActionsFor: aText at: positionInteger max: maxSize
	(positionInteger < 1 or: [ positionInteger > aText size ])
		ifTrue: [ ^ #() ].
	position := positionInteger.
	max := maxSize.
	string := aText asString.
	(self annotationRegex matchingRangesIn: string)
		do: [ :each | 
			(positionInteger between: each first and: each last)
				ifTrue: [ ^ self annotationActionsIn: (string copyFrom: each first to: each last) startAt: each first ] ].
	((string at: positionInteger) = $$ and: [ positionInteger = 1 or: [ (string at: positionInteger - 1) ~= $} ] ])
		ifTrue: [ ^ self allAnnotationActions ].
	^ #()