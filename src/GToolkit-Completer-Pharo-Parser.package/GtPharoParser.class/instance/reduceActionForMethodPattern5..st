generated-reduction actions
reduceActionForMethodPattern5: nodes
	| result |
	result := GtPharoErrorPatternNode new.
	result addToken: (nodes at: 1) to: result selectorParts.
	result smaccError: (nodes at: 2).
	^ result