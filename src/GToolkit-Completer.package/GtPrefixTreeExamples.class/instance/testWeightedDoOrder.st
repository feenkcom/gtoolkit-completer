test-accessing
testWeightedDoOrder
	<gtExample>
	| tree last |
	tree := GtPrefixTree withAll: ((1 to: 100) collect: #asString).
	last := '0'.
	tree
		weightedDo: [ :each | 
			self assert: last < each.
			last := each ].
	^ tree