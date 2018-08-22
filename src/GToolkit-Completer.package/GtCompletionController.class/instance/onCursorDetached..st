private - cursor
onCursorDetached: aCursorElement
	cursorElement := nil.
	overlay detach.
	overlay visibility: BlVisibility hidden