private
moveCursorTo: anInteger on: aCompletionController
	self pauseForCompletion.
	aCompletionController textEditor moveCursorTo: anInteger