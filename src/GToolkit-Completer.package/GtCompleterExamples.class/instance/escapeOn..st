private
escapeOn: completionController
	self pauseForCompletion.
	completionController
		processKeyDown:
			(BlKeyDownEvent new
				key: Key escape;
				modifiers:
					(BlKeyModifiers
						shift: false
						ctrl: false
						alt: false
						cmd: false);
				yourself)