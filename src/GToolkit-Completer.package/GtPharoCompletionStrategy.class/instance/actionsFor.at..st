private
actionsFor: anAST at: anInteger
	^ (self nodeFor: anInteger in: anAST) ifNil: [ #() ] ifNotNil: [ :node | node completionActionsFor: self ]