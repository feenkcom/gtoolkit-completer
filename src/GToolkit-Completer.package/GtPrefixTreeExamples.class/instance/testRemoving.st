test-removing
testRemoving
	<gtExample>
	| tree |
	tree := self oneToHundredTree.
	2 to: 100 by: 2 do: [ :i | tree remove: i printString weight: i ].
	tree do: [ :each | self assert: each asInteger odd ].
	1 to: 100 by: 2 do: [ :i | tree remove: i printString weight: i - 1 ].
	tree do: [ :each | self assert: each asInteger odd ].
	1 to: 100 by: 2 do: [ :i | tree remove: i printString weight: 100 ].
	self assert: tree isEmpty