accessing
popupDelay: aDuration
	self
		assert: [ aDuration isNumber not ]
		description: [ 'Popup delay must not be a Number, it should be a Duration' ].

	PopupDelay := aDuration