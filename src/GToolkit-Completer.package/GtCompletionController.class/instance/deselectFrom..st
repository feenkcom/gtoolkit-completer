private-popup
deselectFrom: anInteger
	anInteger > MaxPopupItems
		ifTrue: [ ^ self ].
	listElement selection deselect: anInteger to: MaxPopupItems