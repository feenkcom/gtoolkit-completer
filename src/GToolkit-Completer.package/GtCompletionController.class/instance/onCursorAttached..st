private - cursor
onCursorAttached: aCursorElement
	cursorElement := aCursorElement.
	overlay attachTo: cursorElement.
	overlay visibility: BlVisibility visible