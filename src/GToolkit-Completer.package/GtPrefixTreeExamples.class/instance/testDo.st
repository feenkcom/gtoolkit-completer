test-iterating
testDo
	<gtExample>
	| count |
	self emptyTree do: [ :each | self assert: false ].
	count := 0.
	self singleItemTree
		do: [ :each | 
			count := count + 1.
			self assert: each = 'test' ].
	self assert: count = 1