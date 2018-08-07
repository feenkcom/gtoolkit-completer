generated-reduction actions
reduceActionForNumberLiteral1: nodes
	| result |
	result := GtPharoNumberLiteralNode new.
	result value: (nodes at: 1).
	^ result