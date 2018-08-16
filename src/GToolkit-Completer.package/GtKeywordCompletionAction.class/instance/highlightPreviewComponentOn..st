private
highlightPreviewComponentOn: aCompletionController
	endPosition <= position
		ifTrue: [ ^ self ].
	self addPreviewAttributes: aCompletionController text from: position + 1 to: endPosition.
	parenIndex notNil
		ifTrue: [ self addPreviewAttributes: aCompletionController text from: parenIndex to: parenIndex ]