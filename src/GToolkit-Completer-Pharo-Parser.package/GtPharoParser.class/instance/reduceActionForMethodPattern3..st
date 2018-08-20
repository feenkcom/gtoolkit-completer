generated-reduction actions
reduceActionForMethodPattern3: nodes
	| result |
	result := GtPharoMethodPatternNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	^ result