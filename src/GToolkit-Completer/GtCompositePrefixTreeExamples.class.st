Class {
	#name : 'GtCompositePrefixTreeExamples',
	#superclass : 'Object',
	#category : 'GToolkit-Completer-Examples'
}

{ #category : 'examples' }
GtCompositePrefixTreeExamples >> compositeTree [
	<gtExample>
	| composite |
	composite := GtCompositePrefixTree
		trees:
			{self oneToFifty.
			self oneToFiftyByTwo}.
	self assert: composite size = 50.
	^ composite
]

{ #category : 'tests' }
GtCompositePrefixTreeExamples >> firstTen [
	<gtExample>
	| composite |
	composite := self compositeTree.
	self
		assert:
			(composite first: 10) asArray
				= #('1' '10' '11' '12' '13' '14' '15' '16' '17' '18').
	^ composite
]

{ #category : 'examples' }
GtCompositePrefixTreeExamples >> oneToFifty [
	<gtExample>
	| tree |
	tree := GtPrefixTree new.
	1 to: 50 do: [ :i | tree add: i printString weight: i ].
	self assert: tree size = 50.
	^ tree
]

{ #category : 'examples' }
GtCompositePrefixTreeExamples >> oneToFiftyByTwo [
	<gtExample>
	| tree |
	tree := GtPrefixTree new.
	1 to: 50 by: 2 do: [ :i | tree add: i printString weight: i ].
	self assert: tree size = 25.
	^ tree
]

{ #category : 'tests' }
GtCompositePrefixTreeExamples >> weightedFirstTen [
	<gtExample>
	| composite |
	composite := self compositeTree.
	self
		assert:
			(composite weightedFirst: 10) asArray
				= #('49' '47' '45' '43' '41' '39' '37' '35' '33' '31').
	^ composite
]
