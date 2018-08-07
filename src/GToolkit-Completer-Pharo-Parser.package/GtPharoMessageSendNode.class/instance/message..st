generated
message: aGtPharoMessageNode
	self message notNil
		ifTrue: [ self message parent: nil ].
	message := aGtPharoMessageNode.
	self message notNil
		ifTrue: [ self message parent: self ]