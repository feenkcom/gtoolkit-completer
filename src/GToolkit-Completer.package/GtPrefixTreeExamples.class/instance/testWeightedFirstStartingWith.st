test-accessing
testWeightedFirstStartingWith
	<gtExample>
	self
		assert:
			(self oneToHundredTree weightedFirst: 10 startingWith: '2') asArray
				= #('29' '28' '27' '26' '25' '24' '23' '22' '21' '20')