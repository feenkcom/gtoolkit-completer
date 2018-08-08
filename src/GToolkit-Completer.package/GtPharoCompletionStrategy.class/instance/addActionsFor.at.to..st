private
addActionsFor: anAST at: anInteger to: actions
	| node |
	node := self nodeFor: anInteger in: anAST.
	node isNil
		ifTrue: [ ^ self ].
	(node isKindOf: GtPharoVariableNode)
		ifTrue: [ self addVariableActionsFor: node at: anInteger to: actions ].
	(node isKindOf: GtPharoMessageNode)
		ifTrue: [ self addMessageActionsFor: node at: anInteger to: actions ].
	(node isKindOf: GtPharoSymbolLiteralNode)
		ifTrue: [ self addSymbolActionsFor: node at: anInteger to: actions ].
	(node isKindOf: GtPharoMethodNode)
		ifTrue: [ self addMethodActionsFor: node at: anInteger to: actions ]