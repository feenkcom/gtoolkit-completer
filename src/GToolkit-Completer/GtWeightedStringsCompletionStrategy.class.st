Class {
	#name : #GtWeightedStringsCompletionStrategy,
	#superclass : #GtStringsCompletionStrategy,
	#category : #'GToolkit-Completer-Strategies'
}

{ #category : #accessing }
GtWeightedStringsCompletionStrategy >> completionStringStreamStartingWith: aString [
	^ self completions asyncWeightedStreamStartingWith: aString
]
