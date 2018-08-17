actions
uninstall
	popupEventFilters do: [ :each | listElement removeEventFilter: each ].
	popupEventHandlers do: [ :each | listElement removeEventHandler: each ].
	eventFilters do: [ :each | textElement removeEventFilter: each ].
	eventHandlers do: [ :each | self textEditor removeEventHandler: each ]