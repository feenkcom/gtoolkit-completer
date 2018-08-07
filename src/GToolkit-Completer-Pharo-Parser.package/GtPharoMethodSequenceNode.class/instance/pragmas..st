generated
pragmas: anOrderedCollection
	self setParents: self pragmas to: nil.
	pragmas := anOrderedCollection.
	self setParents: self pragmas to: self