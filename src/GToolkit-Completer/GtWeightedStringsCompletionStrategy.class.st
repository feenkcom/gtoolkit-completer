Class {
	#name : #GtWeightedStringsCompletionStrategy,
	#superclass : #GtStringsCompletionStrategy,
	#category : 'GToolkit-Completer'
}

{ #category : #accessing }
GtWeightedStringsCompletionStrategy >> first: anInteger startingWith: aString [
	^ completions weightedFirst: anInteger startingWith: aString
]
