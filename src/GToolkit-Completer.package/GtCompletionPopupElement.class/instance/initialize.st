initialization
initialize
	super initialize.

	self constraintsDo: [ :c | c ignoreByLayout ].
	self preventMouseEvents.

	overlayListener := GtCompletionPopupListener for: self