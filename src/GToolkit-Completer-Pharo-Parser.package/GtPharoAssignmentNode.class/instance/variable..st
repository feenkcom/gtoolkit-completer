generated
variable: aGtPharoVariableNode
	self variable notNil
		ifTrue: [ self variable parent: nil ].
	variable := aGtPharoVariableNode.
	self variable notNil
		ifTrue: [ self variable parent: self ]