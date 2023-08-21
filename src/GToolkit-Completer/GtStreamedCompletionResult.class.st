Class {
	#name : #GtStreamedCompletionResult,
	#superclass : #GtCompletionResult,
	#instVars : [
		'stream'
	],
	#category : #'GToolkit-Completer-Results'
}

{ #category : #'instance creation' }
GtStreamedCompletionResult class >> onStream: anAsyncStream [
	^ (self new)
		stream: anAsyncStream;
		yourself
]

{ #category : #accessing }
GtStreamedCompletionResult >> asAsyncStream [
	^ stream asyncSimilarCopy
]

{ #category : #accessing }
GtStreamedCompletionResult >> completionActionsWithIndexDo: aBlock [
	| index localStream item |
	localStream := stream asyncSimilarCopy.
	index := 1.
	[ item := localStream next wait.
	item isSome ]
		whileTrue:
			[ aBlock value: item value value: index.
			index := index + 1 ]
]

{ #category : #accessing }
GtStreamedCompletionResult >> gtLiveFor: aView [
	<gtView>
	^ aView forward
		title: 'Items';
		priority: 10;
		object: [ self stream ];
		view: #gtLiveFor:
]

{ #category : #testing }
GtStreamedCompletionResult >> hasCompletionActions [
	| localStream |
	localStream := stream asyncSimilarCopy.
	^ localStream hasNext wait
		and:
			[ localStream := stream asyncSimilarCopy.
			localStream next wait value affectsText or: [ localStream hasNext wait ] ]
]

{ #category : #accessing }
GtStreamedCompletionResult >> popupPosition [
	self completionActionsWithIndexDo: [ :each :i | each searchStartPosition ifNotNil: [ :pos | ^ pos ] ].
	^ nil
]

{ #category : #drawing }
GtStreamedCompletionResult >> showOn: aController [
	aController showListItems: stream
]

{ #category : #accessing }
GtStreamedCompletionResult >> stream [
	^ stream
]

{ #category : #accessing }
GtStreamedCompletionResult >> stream: anAsyncStream [
	stream := anAsyncStream cached
]
