Class {
	#name : #GtWeightedStringsCompletionStrategy,
	#superclass : #GtStringsCompletionStrategy,
	#category : #'GToolkit-Completer'
}

{ #category : #accessing }
GtWeightedStringsCompletionStrategy >> completionStringStreamStartingWith: aString [
	^ self completions asyncWeightedStreamStartingWith: aString
]

{ #category : #accessing }
GtWeightedStringsCompletionStrategy >> first: anInteger startingWith: aString [
	^ self completions weightedFirst: anInteger startingWith: aString
]
