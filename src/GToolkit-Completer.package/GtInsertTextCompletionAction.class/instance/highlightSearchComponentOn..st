private
highlightSearchComponentOn: aCompletionController
	searchStartPosition > position
		ifTrue: [ ^ self ].
	self addSearchAttributes: aCompletionController text from: searchStartPosition to: position