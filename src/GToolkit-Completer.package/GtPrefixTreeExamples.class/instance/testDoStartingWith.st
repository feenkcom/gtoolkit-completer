test-iterating
testDoStartingWith
	<gtExample>
	| count |
	self emptyTree do: [ :each | self assert: false ] startingWith: '1'.
	count := 0.
	self oneToHundredTree
		do: [ :each | 
			count := count + 1.
			self assert: each first = $1 ]
		startingWith: '1'.
	self assert: count = 12.
	self oneToHundredTree do: [ :each | self assert: false ] startingWith: '1;'