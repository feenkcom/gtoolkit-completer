private-popup
selectAction: anAction
	| actions index |
	self deselectFrom: 1.
	actions := self completionActions.
	index := (1 to: actions size) detect: [ :i | (actions at: i) = anAction ] ifNone: [ ^ self ].
	self selectIndex: index