private-selector
selectorsForReceiver: aBehavior matching: aString
	| tree |
	tree := aBehavior notNil
		ifTrue: [ GtPrefixTree withAll: aBehavior allSelectors ]
		ifFalse: [ SelectorCache ].
	^ tree weightedFirst: maxItems startingWith: aString