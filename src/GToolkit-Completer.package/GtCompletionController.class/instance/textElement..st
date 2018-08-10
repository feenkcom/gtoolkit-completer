initialize-release
textElement: anEditorElement
	textElement := anEditorElement.
	textElement when: BrTextEditorCursorElementAddedEvent do: [ :e |
	    cursorElement := e cursorElement ].
	textElement when: BrTextEditorCursorElementRemovedEvent do: [ :e |
	    cursorElement := nil ].