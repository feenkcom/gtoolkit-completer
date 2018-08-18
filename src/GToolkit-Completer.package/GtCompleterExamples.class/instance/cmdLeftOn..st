private
cmdLeftOn: completionController
	self pauseForCompletion.
	completionController
		processKeyDown:
			(BlKeyDownEvent new
				key: Key arrowLeft;
				modifiers:
					(BlKeyModifiers
						shift: false
						ctrl: false
						alt: false
						cmd: true);
				yourself)