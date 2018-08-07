generated-reduction actions
reduceActionForMethod2: nodes
	| result |
	result := GtPharoMethodErrorNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result smaccError: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result body: (nodes at: 2).
	^ result