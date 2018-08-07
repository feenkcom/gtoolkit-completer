generated
receiver: aGtPharoValueNode
	self receiver notNil
		ifTrue: [ self receiver parent: nil ].
	receiver := aGtPharoValueNode.
	self receiver notNil
		ifTrue: [ self receiver parent: self ]