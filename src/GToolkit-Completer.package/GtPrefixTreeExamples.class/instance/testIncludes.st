tests
testIncludes
	<gtExample>
	self assert: (self emptyTree includes: 'test') not.
	self assert: (self emptyTree includes: '') not.
	self assert: (self singleItemTree includes: 'test').
	self assert: (self singleItemTree includes: '') not.
	self assert: (self singleItemTree includes: 'asdf') not