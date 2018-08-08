class initialization
initialize
	SelectorCache := GtPrefixTree new.
	Smalltalk allClassesDo: [ :each | SelectorCache addAll: each selectors ]