generated-reduction actions
reduceActionForStatements2: nodes
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: (result at: 2).
	^ result