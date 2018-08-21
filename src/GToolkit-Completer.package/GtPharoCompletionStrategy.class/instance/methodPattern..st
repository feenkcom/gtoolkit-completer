accessing
methodPattern: aMethodPattern
	methodPattern := aMethodPattern.
	methodPattern notNil
		ifTrue: [ methodPattern variables do: [ :each | variables add: each name value ] ].
	self isMethod: false