examples
oneToHundredTree
	<gtExample>
	| tree |
	tree := GtPrefixTree new.
	1 to: 100 do: [ :i | tree add: i printString weight: i ].
	^ tree