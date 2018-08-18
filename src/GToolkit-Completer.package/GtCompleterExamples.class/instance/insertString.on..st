private
insertString: aString on: completionController
	self deleteSelectedTextOn: completionController.
	aString
		do: [ :each | 
			| position |
			position := completionController textEditor cursor position.
			completionController textEditor insertString: (String with: each) at: position.
			self moveCursorTo: position + 1 on: completionController ]