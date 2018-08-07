generated-reduction actions
reduceActionForSequence1: nodes
	| result |
	result := GtPharoSequenceNode new.
	result addTokens: (nodes at: 1) to: result periods.
	^ result