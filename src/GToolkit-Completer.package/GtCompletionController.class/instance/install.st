actions
install
	eventHandlers := {(BlEventHandler
		on: BrTextEditorInsertedEvent
		do: [ :event | self textInserted: event ]).
	(BlEventHandler
		on: BrTextEditorDeletedEvent
		do: [ :event | self textDeleted: event ]).
	(BlEventHandler
		on: BrTextEditorCursorMovedEvent
		do: [ :event | self cursorMoved: event ])}.
	eventHandlers do: [ :each | self textEditor addEventHandler: each ].
	eventFilters := {(BlEventHandler
		on: BlKeystrokeEvent
		do: [ :event | self processKeystroke: event ]).
	(BlEventHandler
		on: BlKeyDownEvent
		do: [ :event | self processKeyDown: event ])}.
	eventFilters do: [ :each | textElement addEventFilter: each ].
	popupEventHandlers := {(BlEventHandler
		on: BrSelectionChanged
		do: [ :event | self showPreview ]).
	(BlEventHandler
		on: BlDoubleClickEvent
		do: [ :event | self doubleClickList: true ])}.
	popupEventHandlers do: [ :each | listElement addEventHandler: each ].
	popupEventFilters := {(BlEventHandler
		on: BlKeystrokeEvent
		do: [ :event | self processPopupKeystroke: event ])}.
	popupEventFilters do: [ :each | listElement addEventFilter: each ]