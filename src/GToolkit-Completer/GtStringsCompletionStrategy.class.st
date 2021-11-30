Class {
	#name : #GtStringsCompletionStrategy,
	#superclass : #GtCompletionStrategy,
	#instVars : [
		'completions',
		'completionsBlock'
	],
	#category : #'GToolkit-Completer'
}

{ #category : #private }
GtStringsCompletionStrategy >> buildCompletions [
	^ GtPrefixTree new
]

{ #category : #accessing }
GtStringsCompletionStrategy >> completionStringStreamStartingWith: aString [
	^ self completions asyncStreamStartingWith: aString
]

{ #category : #accessing }
GtStringsCompletionStrategy >> completions [
	^ completions ifNil: [ completions := completionsBlock
		ifNil: [ self buildCompletions ]
		ifNotNil: [ :aBlock | aBlock value ] ]
]

{ #category : #'initialize-release' }
GtStringsCompletionStrategy >> completions: prefixTreeOrBlock [
	completionsBlock := prefixTreeOrBlock
]

{ #category : #accessing }
GtStringsCompletionStrategy >> first: anInteger startingWith: aString [
	^ self completions first: anInteger startingWith: aString
]

{ #category : #'gt-extensions' }
GtStringsCompletionStrategy >> gtCompletionsFor: aView [
	<gtView>
	^ aView list
		title: 'Completions';
		items: [ self completions asOrderedCollection ]
]

{ #category : #testing }
GtStringsCompletionStrategy >> hasCompletionEntryFor: aString [
	self completions
		do: [ :each | 
			each ~= aString
				ifTrue: [ ^ true ] ]
		startingWith: aString.
	^ false
]
