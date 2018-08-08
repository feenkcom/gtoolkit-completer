accessing
completionActionsFor: aText at: positionInteger max: maxSize
	| actions |
	max := maxSize.
	actions := OrderedCollection new.
	(self parseSource: aText asString) ifNotNil: [ :tree | self addActionsFor: tree at: positionInteger to: actions ].
	^ actions