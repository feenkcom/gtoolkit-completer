testing
isUncompletedAt: position
	^ (self text attributesAt: position) anySatisfy: [ :each | each isKindOf: GtCompletionPartAttribute ]