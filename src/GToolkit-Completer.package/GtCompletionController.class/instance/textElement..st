initialize-release
textElement: anEditorElement
	textElement := anEditorElement.
	textElement
		when: BrTextEditorCursorElementAddedEvent
		do: [ :anEvent | self onCursorAttached: anEvent cursorElement ].
	textElement
		when: BrTextEditorCursorElementRemovedEvent
		do: [ :anEvent | self onCursorDetached: anEvent cursorElement ].

	completionDelay element: textElement