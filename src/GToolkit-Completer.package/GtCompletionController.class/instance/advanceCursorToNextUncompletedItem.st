private
advanceCursorToNextUncompletedItem
	self nextUncompletedItem
		ifNotNil: [ :position | 
			self textEditor moveCursorTo: position.
			self removeUncompletedAttributeAt: position.
			^ true ].
	^ false