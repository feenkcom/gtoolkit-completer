private
cmdRightOn: completionController
	self pauseForCompletion.
	completionController
		processKeyDown:
			(BlKeyDownEvent new
				key: Key arrowRight;
				modifiers:
					(BlKeyModifiers
						shift: false
						ctrl: false
						alt: false
						cmd: true);
				yourself)