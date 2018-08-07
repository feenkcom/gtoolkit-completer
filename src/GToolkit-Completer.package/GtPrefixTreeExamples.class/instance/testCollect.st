test-enumerating
testCollect
	<gtExample>
	| tree collected |
	tree := self oneToHundredTree.
	collected := tree collect: [ :each | each asInteger ].
	self assert: tree size = collected size.
	1 to: 100 do: [ :i | self assert: (collected includes: i) ]