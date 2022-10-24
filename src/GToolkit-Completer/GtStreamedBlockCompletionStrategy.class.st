Class {
	#name : #GtStreamedBlockCompletionStrategy,
	#superclass : #GtStreamedCompletionStrategy,
	#instVars : [
		'streamingBlock'
	],
	#category : #'GToolkit-Completer-Strategies'
}

{ #category : #accessing }
GtStreamedBlockCompletionStrategy >> completionStringStreamStartingWith: aString [
	^ streamingBlock value: aString
]

{ #category : #accessing }
GtStreamedBlockCompletionStrategy >> hasCompletionEntryFor: aString [
	^ true
]

{ #category : #initialization }
GtStreamedBlockCompletionStrategy >> initialize [
	super initialize.
	streamingBlock := [ :text | #() asAsyncStream ]
]

{ #category : #initialization }
GtStreamedBlockCompletionStrategy >> streamingBlock: aBlock [
	streamingBlock := aBlock
]
