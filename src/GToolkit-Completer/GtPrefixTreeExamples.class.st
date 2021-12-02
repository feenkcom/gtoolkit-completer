Class {
	#name : #GtPrefixTreeExamples,
	#superclass : #Object,
	#category : #'GToolkit-Completer-Examples'
}

{ #category : #examples }
GtPrefixTreeExamples >> allSymbolsTree [
	<gtExample>
	| symbols tree |
	tree := GtPrefixTree new.
	symbols := Symbol allSymbols.
	symbols do: [ :each | tree add: each ].
	^ tree
]

{ #category : #examples }
GtPrefixTreeExamples >> emptyTree [
	<gtExample>
	^ GtPrefixTree new
]

{ #category : #examples }
GtPrefixTreeExamples >> oneToHundredTree [
	<gtExample>
	| tree |
	tree := GtPrefixTree new.
	1 to: 100 do: [ :i | tree add: i printString weight: i ].
	^ tree
]

{ #category : #examples }
GtPrefixTreeExamples >> singleItemFirstStartingWith [
	<gtExample>
	| tree |
	tree := GtPrefixTree new.
	tree add: 'abc'.
	self assert: (tree first: 100 startingWith: 'aa') isEmpty.
	^ tree
]

{ #category : #examples }
GtPrefixTreeExamples >> singleItemTree [
	<gtExample>
	^ self emptyTree
		add: 'test';
		yourself
]

{ #category : #examples }
GtPrefixTreeExamples >> teamTestTree [
	<gtExample>
	^ self emptyTree
		addAll: #('test' 'team');
		yourself
]

{ #category : #'test-enumerating' }
GtPrefixTreeExamples >> testCollect [
	<gtExample>
	| tree collected |
	tree := self oneToHundredTree.
	collected := tree collect: [ :each | each asInteger ].
	self assert: tree size = collected size.
	1 to: 100 do: [ :i | self assert: (collected includes: i) ]
]

{ #category : #'test-iterating' }
GtPrefixTreeExamples >> testDo [
	<gtExample>
	| count |
	self emptyTree do: [ :each | self assert: false ].
	count := 0.
	self singleItemTree
		do: [ :each | 
			count := count + 1.
			self assert: each = 'test' ].
	self assert: count = 1
]

{ #category : #'test-iterating' }
GtPrefixTreeExamples >> testDoStartingWith [
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
]

{ #category : #'test-accessing' }
GtPrefixTreeExamples >> testFirst [
	<gtExample>
	self assert: (self emptyTree first: 10) isEmpty.
	self assert: (self singleItemTree first: 10) asArray = #('test').
	self assert: (self oneToHundredTree first: 3) asArray = #('1' '10' '100')
]

{ #category : #'test-accessing' }
GtPrefixTreeExamples >> testFirstStartingWith [
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
]

{ #category : #tests }
GtPrefixTreeExamples >> testIncludes [
	<gtExample>
	self assert: (self emptyTree includes: 'test') not.
	self assert: (self emptyTree includes: '') not.
	self assert: (self singleItemTree includes: 'test').
	self assert: (self singleItemTree includes: '') not.
	self assert: (self singleItemTree includes: 'asdf') not
]

{ #category : #'tests-testing' }
GtPrefixTreeExamples >> testIsEmpty [
	<gtExample>
	self assert: self emptyTree isEmpty.
	self assert: self singleItemTree notEmpty
]

{ #category : #'test-removing' }
GtPrefixTreeExamples >> testRemoving [
	<gtExample>
	| tree |
	tree := self oneToHundredTree.
	2 to: 100 by: 2 do: [ :i | tree remove: i printString weight: i ].
	tree do: [ :each | self assert: each asInteger odd ].
	1 to: 100 by: 2 do: [ :i | tree remove: i printString weight: i - 1 ].
	tree do: [ :each | self assert: each asInteger odd ].
	1 to: 100 by: 2 do: [ :i | tree remove: i printString weight: 100 ].
	self assert: tree isEmpty
]

{ #category : #'test-enumerating' }
GtPrefixTreeExamples >> testSelect [
	<gtExample>
	| tree selected items |
	tree := self oneToHundredTree.
	selected := tree select: [ :each | true ].
	self assert: tree size = selected size.
	self assert: tree maxWeight = selected maxWeight.
	items := OrderedCollection new.
	tree weightedDo: [ :each | items add: each ].
	selected weightedDo: [ :each | self assert: items removeFirst = each ]
]

{ #category : #'test-iterating' }
GtPrefixTreeExamples >> testStream [
	<gtExample>
	
	| tree streamElements stream |
	tree := self oneToHundredTree.
	stream := tree asyncStreamStartingWith: ''.
	streamElements := Set withAll: stream asyncSimilarCopy toArray wait.
	self assert: streamElements size equals: tree size.
	tree do: [ :each | streamElements remove: each ].
	self assert: streamElements isEmpty.
	streamElements := Set withAll: (tree asyncStreamStartingWith: '1') toArray wait.
	tree do: [ :each | streamElements remove: each ] startingWith: '1'.
	self assert: streamElements isEmpty.
	^ stream
]

{ #category : #'test-iterating' }
GtPrefixTreeExamples >> testStreamNonExistantElement [
	<gtExample>
	
	| tree stream streamElements |
	tree := GtPrefixTree withAll: #('self' 'true' 'false' 'nil' 'thisContext').
	stream := tree asyncStreamStartingWith: 'no'.
	streamElements := stream asyncSimilarCopy toArray wait.
	self assert: streamElements isEmpty.
	^ stream
]

{ #category : #'test-iterating' }
GtPrefixTreeExamples >> testWeightedDo [
	<gtExample>
	| i |
	i := 100.
	self oneToHundredTree
		weightedDo: [ :each | 
			self assert: i printString = each.
			i := i - 1 ].
	self assert: i = 0
]

{ #category : #'test-accessing' }
GtPrefixTreeExamples >> testWeightedDoOrder [
	<gtExample>
	| tree last |
	tree := GtPrefixTree withAll: ((1 to: 100) collect: #asString).
	last := '0'.
	tree
		weightedDo: [ :each | 
			self assert: last < each.
			last := each ].
	^ tree
]

{ #category : #'test-accessing' }
GtPrefixTreeExamples >> testWeightedFirstStartingWith [
	<gtExample>
	self
		assert:
			(self oneToHundredTree weightedFirst: 10 startingWith: '2') asArray
				= #('29' '28' '27' '26' '25' '24' '23' '22' '21' '20')
]

{ #category : #'test-iterating' }
GtPrefixTreeExamples >> testWeightedStream [
	<gtExample>
	
	| tree streamElements stream |
	tree := self oneToHundredTree.
	stream := tree asyncWeightedStreamStartingWith: ''.
	streamElements := stream asyncSimilarCopy toArray wait.
	self assert: streamElements size equals: tree size.
	(100 to: 1 by: -1) keysAndValuesDo: [ :i :value | self assert: (streamElements at: i) equals: value printString ].
	^ stream
]
