private - list selection
selectAction: aCompletionAction
	"Select the given completion action deselecting the other ones"

	self selectAt: (self completionActions indexOf: aCompletionAction ifAbsent: [ ^ self deselectAll ])