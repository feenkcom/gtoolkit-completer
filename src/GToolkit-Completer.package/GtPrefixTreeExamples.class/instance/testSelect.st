test-enumerating
testSelect
	<gtExample>
	| tree selected items |
	tree := self oneToHundredTree.
	selected := tree select: [ :each | true ].
	self assert: tree size = selected size.
	self assert: tree maxWeight = selected maxWeight.
	items := OrderedCollection new.
	tree weightedDo: [ :each | items add: each ].
	selected weightedDo: [ :each | self assert: items removeFirst = each ]