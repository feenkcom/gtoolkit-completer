test-accessing
testFirst
	<gtExample>
	self assert: (self emptyTree first: 10) isEmpty.
	self assert: (self singleItemTree first: 10) asArray = #('test').
	self assert: (self oneToHundredTree first: 3) asArray = #('1' '10' '100')