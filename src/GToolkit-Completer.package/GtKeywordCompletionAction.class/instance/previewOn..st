executing
previewOn: aCompletionController
	self highlightSearchComponentOn: aCompletionController.
	self addKeywordsAndArgsOn: aCompletionController.
	self addParenthesesOn: aCompletionController.
	self highlightPreviewComponentOn: aCompletionController