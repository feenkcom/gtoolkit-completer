Class {
	#name : #GtWeightedStringsCompletionStrategy,
	#superclass : #GtStringsCompletionStrategy,
	#category : #'GToolkit-Completer-Strategies'
}

{ #category : #private }
GtWeightedStringsCompletionStrategy >> completionStringStreamStartingWith: aString [
	^ self completions asyncWeightedStreamStartingWith: aString
]
