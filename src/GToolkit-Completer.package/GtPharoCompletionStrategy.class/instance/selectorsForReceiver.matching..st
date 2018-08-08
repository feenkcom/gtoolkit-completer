private-selector
selectorsForReceiver: aNode matching: aString
	"currently we don't implement any type inferencing"

	^ SelectorCache weightedFirst: max startingWith: aString