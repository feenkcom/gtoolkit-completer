generated-reduction actions
reduceActionForValue6: nodes
	| result |
	result := GtPharoErrorNode new.
	result smaccError: (nodes at: 1).
	^ result