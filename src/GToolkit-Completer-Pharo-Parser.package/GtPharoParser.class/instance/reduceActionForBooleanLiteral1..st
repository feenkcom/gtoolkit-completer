generated-reduction actions
reduceActionForBooleanLiteral1: nodes
	| result |
	result := GtPharoBooleanLiteralNode new.
	result value: (nodes at: 1).
	^ result