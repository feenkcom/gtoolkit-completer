generated
pattern: aGtPharoMethodPatternNode
	self pattern notNil
		ifTrue: [ self pattern parent: nil ].
	pattern := aGtPharoMethodPatternNode.
	self pattern notNil
		ifTrue: [ self pattern parent: self ]