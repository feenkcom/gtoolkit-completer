generated-reduction actions
reduceActionForStringLiteral1: nodes
	| result |
	result := GtPharoStringLiteralNode new.
	result value: (nodes at: 1).
	^ result