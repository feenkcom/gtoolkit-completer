executing
undoDrillDownOn: aCompletionController
	actions reverseDo: [ :each | each undoDrillDownOn: aCompletionController ]