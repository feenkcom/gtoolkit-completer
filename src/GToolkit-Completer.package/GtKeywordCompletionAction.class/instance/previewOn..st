executing
previewOn: aCompletionController
	endPosition := position.
	self
		keywordsAndArgumentNamesDo: [ :keyword :arg | 
			aCompletionController textEditor insertString: keyword , ' ' at: endPosition.
			endPosition := endPosition + keyword size + 1.
			aCompletionController textEditor insertString: arg , ' ' at: endPosition.
			(aCompletionController text from: endPosition to: endPosition + arg size - 1) attributes: {GtCompletionPartAttribute new}.
			endPosition := endPosition + arg size + 1 ]