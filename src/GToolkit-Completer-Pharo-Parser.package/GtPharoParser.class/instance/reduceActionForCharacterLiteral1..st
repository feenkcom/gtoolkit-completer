generated-reduction actions
reduceActionForCharacterLiteral1: nodes
	| result |
	result := GtPharoCharacterLiteralNode new.
	result value: (nodes at: 1).
	^ result