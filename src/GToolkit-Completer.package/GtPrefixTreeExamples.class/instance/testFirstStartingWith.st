test-accessing
testFirstStartingWith
	<gtExample>
	self assert: (self emptyTree first: 10 startingWith: '') isEmpty.
	self assert: (self emptyTree first: 10 startingWith: 't') isEmpty.
	self assert: (self singleItemTree first: 10 startingWith: '') asArray = #('test').
	self assert: (self singleItemTree first: 10 startingWith: 't') asArray = #('test').
	self assert: (self singleItemTree first: 10 startingWith: 'z') isEmpty.
	self
		assert:
			(self teamTestTree first: 10 startingWith: 't') asSortedCollection asArray
				= #('team' 'test')