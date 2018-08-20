generated-reduction actions
reduceActionForMethodPattern1: nodes
	| result |
	result := GtPharoMethodPatternNode new.
	result addToken: (nodes at: 1) to: result selectorParts.
	^ result