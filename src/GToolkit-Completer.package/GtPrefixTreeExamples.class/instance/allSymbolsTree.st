examples
allSymbolsTree
	<gtExample>
	| symbols tree |
	tree := GtPrefixTree new.
	symbols := Symbol allSymbols.
	symbols do: [ :each | tree add: each ].
	^ tree