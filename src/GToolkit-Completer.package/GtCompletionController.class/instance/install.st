actions
install
	self textEditor
		when: BrTextEditorInsertedEvent do: [ :event | self textInserted: event ];
		when: BrTextEditorDeletedEvent do: [ :event | self textDeleted: event ];
		when: BrTextEditorCursorMovedEvent do: [ :event | self cursorMoved: event ].
	eventFilters := {(BlEventHandler
		on: BlKeystrokeEvent
		do: [ :event | self processKeystroke: event ]).
	(BlEventHandler
		on: BlKeyDownEvent
		do: [ :event | self processKeyDown: event ])}.
	eventFilters do: [ :each | textElement addEventFilter: each ].
	listElement
		when: BrSelectionChanged do: [ :event | self updatePreview ];
		when: BlDblClickEvent do: [ :event | self doubleClickList: true ].
	popupEventFilters := {(BlEventHandler
		on: BlKeystrokeEvent
		do: [ :event | self processPopupKeystroke: event ])}.
	popupEventFilters do: [ :each | listElement addEventFilter: each ]