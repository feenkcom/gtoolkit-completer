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
	deletedString := (aCompletionController text from: from to: to) asString.
	aCompletionController textEditor delete: from - 1 to: to
]

{ #category : #private }
GtDeleteTextCompletionAction >> to [
	^ to
]

{ #category : #private }
GtDeleteTextCompletionAction >> to: anInteger [
	to := anInteger
]

{ #category : #executing }
GtDeleteTextCompletionAction >> undoPreviewOn: aCompletionController [
	deletedString isNil
		ifTrue: [ ^ self ].
	aCompletionController textEditor insertString: deletedString at: from - 1
]
