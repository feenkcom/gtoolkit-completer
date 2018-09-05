Class {
	#name : #GtDeleteTextCompletionAction,
	#superclass : #GtCompletionAction,
	#instVars : [
		'from',
		'to',
		'deletedString'
	],
	#category : 'GToolkit-Completer'
}

{ #category : #'instance creation' }
GtDeleteTextCompletionAction class >> labeled: aString from: fromIndex to: toIndex [
	^ (self labeled: aString)
		from: fromIndex;
		to: toIndex;
		yourself
]

{ #category : #comparing }
GtDeleteTextCompletionAction >> = anObject [
	^ super = anObject and: [ self from = anObject from and: [ self to = anObject to ] ]
]

{ #category : #executing }
GtDeleteTextCompletionAction >> finishCompletionOn: aCompletionController moveCursor: aBoolean [
	from > to
		ifTrue: [ ^ self ].
	deletedString := (aCompletionController text from: from to: to) asString.
	self delete: from - 1 to: to on: aCompletionController
]

{ #category : #private }
GtDeleteTextCompletionAction >> from [
	^ from
]

{ #category : #private }
GtDeleteTextCompletionAction >> from: anInteger [
	from := anInteger
]

{ #category : #comparing }
GtDeleteTextCompletionAction >> hash [
	^ (super hash bitXor: self from hash) bitXor: self to hash
]

{ #category : #executing }
GtDeleteTextCompletionAction >> previewOn: aCompletionController [
	from > to
		ifTrue: [ ^ self ].
	(aCompletionController text from: from to: to) attributes: {GtPreviewDeletionAttribute new}.
	aCompletionController textEditor invalidate: from to: to.
	aCompletionController textEditor update: from to: to
]

{ #category : #private }
GtDeleteTextCompletionAction >> to [
	^ to
]

{ #category : #private }
GtDeleteTextCompletionAction >> to: anInteger [
	to := anInteger
]

{ #category : #translating }
GtDeleteTextCompletionAction >> translateBy: anIndex [
	super translateBy: anIndex.
	from := from + anIndex.
	to := to + anIndex
]

{ #category : #executing }
GtDeleteTextCompletionAction >> undoDrillDownOn: aCompletionController [
	deletedString isNil
		ifTrue: [ ^ self ].
	self insert: deletedString at: from - 1 on: aCompletionController
]

{ #category : #executing }
GtDeleteTextCompletionAction >> undoPreviewOn: aCompletionController [
	aCompletionController text clearAttributes: from to: to if: [ :each | each class = GtPreviewDeletionAttribute ].
	aCompletionController textEditor invalidate: from to: to.
	aCompletionController textEditor update: from to: to
]
