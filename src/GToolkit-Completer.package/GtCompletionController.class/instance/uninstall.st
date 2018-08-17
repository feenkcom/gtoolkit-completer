actions
uninstall
	popupEventFilters do: [ :each | listElement removeEventFilter: each ].
	self flag: 'BrSimpleList does not understand #unsubscribe:'.
	"listElement unsubscribe: self."
	eventFilters do: [ :each | textElement removeEventFilter: each ].
	self flag: 'BrTextEditor does not understand #unsubscribe:'.
	"self textEditor unsubscribe: self"