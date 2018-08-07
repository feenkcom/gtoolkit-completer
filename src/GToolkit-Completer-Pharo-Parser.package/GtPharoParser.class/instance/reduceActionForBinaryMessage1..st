generated-reduction actions
reduceActionForBinaryMessage1: nodes
	| result |
	result := GtPharoBinaryMessageNode new.
	result selectorPart: (nodes at: 1).
	result value: (nodes at: 2).
	^ result