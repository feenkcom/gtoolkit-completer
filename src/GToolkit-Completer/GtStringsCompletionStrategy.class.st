Class {
	#name : #GtStringsCompletionStrategy,
	#superclass : #GtCompletionStrategy,
	#instVars : [
		'completions'
	],
	#category : 'GToolkit-Completer'
}

{ #category : #'initialize-release' }
GtStringsCompletionStrategy >> completions: prefixTree [
	completions := prefixTree
]

{ #category : #accessing }
GtStringsCompletionStrategy >> first: anInteger startingWith: aString [
	^ completions first: anInteger startingWith: aString
]

{ #category : #testing }
GtStringsCompletionStrategy >> hasCompletionEntryFor: aString [
	completions
		do: [ :each | 
			each ~= aString
				ifTrue: [ ^ true ] ]
		startingWith: aString.
	^ false
]

{ #category : #'initialize-release' }
GtStringsCompletionStrategy >> initialize [
	super initialize.
	completions := GtPrefixTree new
]
