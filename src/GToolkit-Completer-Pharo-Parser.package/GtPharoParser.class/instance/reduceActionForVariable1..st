generated-reduction actions
reduceActionForVariable1: nodes
	| result |
	result := GtPharoVariableNode new.
	result name: (nodes at: 1).
	^ result