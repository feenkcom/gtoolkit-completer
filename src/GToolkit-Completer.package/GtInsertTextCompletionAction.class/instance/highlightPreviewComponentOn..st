private
highlightPreviewComponentOn: aCompletionController
	self text size <= 0
		ifTrue: [ ^ self ].
	self addPreviewAttributes: aCompletionController text from: position + 1 to: position + self text size