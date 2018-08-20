generated
smaccError: aSmaCCError
	self smaccError notNil
		ifTrue: [ self smaccError parent: nil ].
	smaccError := aSmaCCError.
	self smaccError notNil
		ifTrue: [ self smaccError parent: self ]