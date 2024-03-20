Class {
	#name : #GtPrefixTreeFilterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Completer-Examples'
}

{ #category : #accessing }
GtPrefixTreeFilterExamples >> asyncStreamStartingWith [
	<gtExample>
	| stream |
	stream := self oddNumberFilteredTree asyncStreamStartingWith: '2'.
	self
		assert: stream asyncSimilarCopy toArray wait asArray
		equals: #('21' '23' '25' '27' '29').
	^ stream
]

{ #category : #accessing }
GtPrefixTreeFilterExamples >> asyncWeightedStreamStartingWith [
	<gtExample>
	| stream |
	stream := self oddNumberFilteredTree asyncWeightedStreamStartingWith: '2'.
	self
		assert: stream asyncSimilarCopy toArray wait asArray
		equals: #('21' '23' '25' '27' '29') reversed.
	^ stream
]

{ #category : #accessing }
GtPrefixTreeFilterExamples >> do [
	<gtExample>
	| count resultStream tree |
	count := 0.
	resultStream := #('3' '31' '33' '35' '37' '39') readStream.
	tree := self oddNumberFilteredTree select: [ :each | each first = $3 ].
	tree do: [ :each | self assert: each equals: resultStream next ].
	self assert: resultStream atEnd.
	^ tree
]

{ #category : #accessing }
GtPrefixTreeFilterExamples >> doStartingWith [
	<gtExample>
	| count resultStream tree |
	count := 0.
	resultStream := #('3' '31' '33' '35' '37' '39') readStream.
	tree := self oddNumberFilteredTree.
	tree
		do: [ :each | self assert: each equals: resultStream next ]
		startingWith: '3'.
	self assert: resultStream atEnd.
	^ tree
]

{ #category : #accessing }
GtPrefixTreeFilterExamples >> oddNumberFilteredTree [
	<gtExample>
	| tree |
	tree := GtPrefixTree new.
	1 to: 100 do: [ :i | tree add: i printString weight: i ].
	^ GtPrefixTreeFilter new
		tree: tree;
		filter: [ :each | each asInteger odd ]
]

{ #category : #accessing }
GtPrefixTreeFilterExamples >> weightedDo [
	<gtExample>
	| count resultStream tree |
	count := 0.
	resultStream := #('3' '31' '33' '35' '37' '39') reversed readStream.
	tree := self oddNumberFilteredTree select: [ :each | each first = $3 ].
	tree weightedDo: [ :each | self assert: each equals: resultStream next ].
	self assert: resultStream atEnd.
	^ tree
]

{ #category : #accessing }
GtPrefixTreeFilterExamples >> weightedDoStartingWith [
	<gtExample>
	| count resultStream tree |
	count := 0.
	resultStream := #('3' '31' '33' '35' '37' '39') reversed readStream.
	tree := self oddNumberFilteredTree.
	tree
		weightedDo: [ :each | self assert: each equals: resultStream next ]
		startingWith: '3'.
	self assert: resultStream atEnd.
	^ tree
]
