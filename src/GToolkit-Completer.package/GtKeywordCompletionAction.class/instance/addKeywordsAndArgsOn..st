private
addKeywordsAndArgsOn: aCompletionController
	| first |
	first := true.
	endPosition := position.
	self
		keywordsAndArgumentNamesDo: [ :keyword :arg | 
			first
				ifFalse: [ aCompletionController textEditor insertString: ' ' at: endPosition.
					endPosition := endPosition + 1 ].
			aCompletionController textEditor insertString: keyword , ' ' at: endPosition.
			endPosition := endPosition + keyword size + 1.
			aCompletionController textEditor insertString: arg at: endPosition.
			(aCompletionController text from: endPosition to: endPosition + arg size - 1)
				attributes: {GtCompletionPartAttribute new}.
			endPosition := endPosition + arg size.
			first := false ]