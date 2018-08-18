private
tabOn: completionController
	self pauseForCompletion.
	completionController
		processKeystroke:
			(BlKeystrokeEvent new
				char: Character tab;
				yourself)