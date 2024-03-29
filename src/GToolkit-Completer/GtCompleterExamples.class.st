Class {
	#name : #GtCompleterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Completer-Examples'
}

{ #category : #accessing }
GtCompleterExamples >> alphabetStrategy [
	<gtExample>
	| strategy tree |
	tree := GtPrefixTree new.
	$a asInteger to: $z asInteger do: [ :i | tree add: (String new: i - $a asInteger + 1 withAll: (Character value: i)) ].
	strategy := GtStringsCompletionStrategy new.
	strategy completions: tree.
	^ strategy
]

{ #category : #accessing }
GtCompleterExamples >> completeAlphabetStrategy [
	<gtExample>
	| aCompleter result items |
	
	aCompleter := self completer.
	aCompleter defaultStrategy: self alphabetStrategy.

	result := aCompleter complete: 'c' asRopedText at: 1.
	items := (result stream asyncSimilarCopy take: 10) toArray wait.
	self assert: items size equals: 1.
	self assert: items first equals: (GtInsertTextCompletionAction
			 labeled: 'ccc'
			 completion: 'cc'
			 position: 1
			 from: 1).
	^ result
]

{ #category : #accessing }
GtCompleterExamples >> completer [
	<gtExample>
	| completer |
	
	completer := GtCompleter new.	
	^ completer
]
