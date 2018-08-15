private
ignoreTextEventsWhile: aBlock
	ignoreTextEvents := true.
	aBlock
		ensure: [ ignoreTextEvents := false ]