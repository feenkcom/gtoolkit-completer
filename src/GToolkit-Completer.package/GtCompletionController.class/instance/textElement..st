initialize-release
textElement: anEditorElement
	textElement := anEditorElement.
	textElement when: BrTextEditorCursorElementAddedEvent do: [ :e |
		cursorElement := e cursorElement.
		overlay attachTo: cursorElement ].
	textElement when: BrTextEditorCursorElementRemovedEvent do: [ :e |
		cursorElement := nil.
		overlay detach ].
	completionDelay element: textElement