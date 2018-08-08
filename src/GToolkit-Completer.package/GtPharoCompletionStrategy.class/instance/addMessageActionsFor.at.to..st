private-selector
addMessageActionsFor: messageNode at: anInteger to: actions
	messageNode isUnary
		ifTrue: [ self addUnaryMessageActionsFor: messageNode at: anInteger to: actions ].
	messageNode isKeyword
		ifTrue: [ self addKeywordMessageActionsFor: messageNode at: anInteger to: actions ]