Class {
	#name : 'GtStringsCompletionStrategy',
	#superclass : 'GtCompletionStrategy',
	#instVars : [
		'completions'
	],
	#category : 'GToolkit-Completer'
}

{ #category : 'private' }
GtStringsCompletionStrategy >> buildCompletions [
	^ GtPrefixTree new
]

{ #category : 'accessing' }
GtStringsCompletionStrategy >> completions [
	^ completions ifNil: [ completions := self buildCompletions ]
]

{ #category : 'initialize-release' }
GtStringsCompletionStrategy >> completions: prefixTree [
	completions := prefixTree
]

{ #category : 'accessing' }
GtStringsCompletionStrategy >> first: anInteger startingWith: aString [
	^ self completions first: anInteger startingWith: aString
]

{ #category : 'gt-extensions' }
GtStringsCompletionStrategy >> gtCompletionsFor: aView [
	<gtView>
	^ aView list
		title: 'Completions';
		items: [ self completions asOrderedCollection ]
]

{ #category : 'testing' }
GtStringsCompletionStrategy >> hasCompletionEntryFor: aString [
	self completions
		do: [ :each | 
			each ~= aString
				ifTrue: [ ^ true ] ]
		startingWith: aString.
	^ false
]
