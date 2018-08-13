executing
undoPreviewOn: aCompletionController
	actions reverseDo: [ :each | each undoPreviewOn: aCompletionController ]