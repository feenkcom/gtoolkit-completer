Class {
	#name : #GtCompletionStrategyAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'strategy'
	],
	#category : 'GToolkit-Completer'
}

{ #category : #comparing }
GtCompletionStrategyAttribute >> equals: aTextAttribute [
	^ self strategy == aTextAttribute strategy
]

{ #category : #comparing }
GtCompletionStrategyAttribute >> hash [
	^ self class hash bitXor: self strategy hash
]

{ #category : #accessing }
GtCompletionStrategyAttribute >> strategy [
	^ strategy
]

{ #category : #accessing }
GtCompletionStrategyAttribute >> strategy: completionStrategy [
	strategy := completionStrategy
]
