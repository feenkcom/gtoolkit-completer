generated-reduction actions
reduceActionForUnaryMessage1: nodes
	| result |
	result := GtPharoUnaryMessageNode new.
	result selectorPart: (nodes at: 1).
	^ result