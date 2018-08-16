private
ignoreTextEventsWhile: aBlock
	ignoreTextEvents
		ifTrue: [ ^ aBlock value ].
	ignoreTextEvents := true.
	aBlock
		ensure: [ ignoreTextEvents := false ]