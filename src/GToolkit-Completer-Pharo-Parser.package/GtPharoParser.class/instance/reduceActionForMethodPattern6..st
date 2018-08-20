generated-reduction actions
reduceActionForMethodPattern6: nodes
	| result |
	result := GtPharoErrorPatternNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result addToken: (nodes at: 2) to: result selectorParts.
	result smaccError: (nodes at: 3).
	^ result