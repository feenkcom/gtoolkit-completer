generated-reduction actions
reduceActionForSymbolLiteral1: nodes
	| result |
	result := GtPharoSymbolLiteralNode new.
	result value: (nodes at: 1).
	^ result