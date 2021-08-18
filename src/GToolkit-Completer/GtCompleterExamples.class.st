Class {
	#name : 'GtCompleterExamples',
	#superclass : 'Object',
	#category : 'GToolkit-Completer-Examples'
}

{ #category : 'accessing' }
GtCompleterExamples >> alphabetStrategy [
	<gtExample>
	| strategy tree |
	tree := GtPrefixTree new.
	$a asInteger to: $z asInteger do: [ :i | tree add: (String new: i - $a asInteger + 1 withAll: (Character value: i)) ].
	strategy := GtStringsCompletionStrategy new.
	strategy completions: tree.
	^ strategy
]

{ #category : 'accessing' }
GtCompleterExamples >> completeAlphabetStrategy [
	<gtExample>
	| aCompleter theActions insertAction |
	
	aCompleter := self completer.
	aCompleter defaultStrategy: self alphabetStrategy.

	theActions := aCompleter complete: 'c' asRopedText at: 1.
	self assert: theActions size equals: 1.
	self assert: theActions first equals: (GtInsertTextCompletionAction
			 labeled: 'ccc'
			 completion: 'cc'
			 position: 1
			 from: 1).
	^ theActions
]

{ #category : 'accessing' }
GtCompleterExamples >> completer [
	<gtExample>
	| completer |
	
	completer := GtCompleter new.
	self assert: completer maxCompletionItems equals: 10.		
	^ completer
]
