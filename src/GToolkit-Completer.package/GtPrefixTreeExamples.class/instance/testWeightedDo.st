test-iterating
testWeightedDo
	<gtExample>
	| i |
	i := 100.
	self oneToHundredTree
		weightedDo: [ :each | 
			self assert: i printString = each.
			i := i - 1 ].
	self assert: i = 0