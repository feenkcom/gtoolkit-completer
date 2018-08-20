generated-reduction actions
reduceActionForMethod1: nodes
	| result |
	result := GtPharoMethodNode new.
	result pattern: (nodes at: 1).
	result body: (nodes at: 2).
	^ result