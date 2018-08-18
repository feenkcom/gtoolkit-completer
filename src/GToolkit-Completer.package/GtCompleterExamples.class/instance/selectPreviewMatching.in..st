private
selectPreviewMatching: aString in: completionController
	self pauseForCompletion.
	completionController completionActions isEmpty
		ifTrue: [ ^ self ].
	100
		timesRepeat: [ | action |
			action := completionController selectedCompletionItem.
			(aString match: action label)
				ifTrue: [ ^ self ].
			completionController selectNextItem ]