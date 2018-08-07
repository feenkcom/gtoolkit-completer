actions
uninstall
	popupEventFilters do: [ :each | listElement removeEventFilter: each ].
	listElement unsubscribe: self.
	eventFilters do: [ :each | textElement removeEventFilter: each ].
	self textEditor unsubscribe: self