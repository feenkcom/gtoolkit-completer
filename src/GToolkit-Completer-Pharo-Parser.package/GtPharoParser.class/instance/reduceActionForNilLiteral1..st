generated-reduction actions
reduceActionForNilLiteral1: nodes
	| result |
	result := GtPharoNilLiteralNode new.
	result value: (nodes at: 1).
	^ result