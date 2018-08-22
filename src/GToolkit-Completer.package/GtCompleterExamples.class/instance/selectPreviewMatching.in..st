private
selectPreviewMatching: aString in: completionController
	self pauseForCompletion.
	completionController completionActions isEmpty
		ifTrue: [ ^ self ].
	100
		timesRepeat: [		
			completionController selectedCompletionItemDo: [ :aCompletionItem |
				(aString match: aCompletionItem label)
					ifTrue: [ ^ self ] ].
			completionController selectNextItem ]