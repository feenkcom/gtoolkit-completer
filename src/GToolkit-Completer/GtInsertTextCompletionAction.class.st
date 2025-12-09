Class {
	#name : #GtInsertTextCompletionAction,
	#superclass : #GtCompletionAction,
	#instVars : [
		'text',
		'position',
		'searchStartPosition'
	],
	#category : #'GToolkit-Completer-Actions'
}

{ #category : #'instance creation' }
GtInsertTextCompletionAction class >> labeled: aString completion: completionString position: anInteger [
	^ self
		labeled: aString
		completion: completionString
		position: anInteger
		from: anInteger - aString size + completionString size + 1
]

{ #category : #'instance creation' }
GtInsertTextCompletionAction class >> labeled: aString completion: completionString position: anInteger from: searchStartInteger [
	^ (self labeled: aString)
		text: completionString;
		position: anInteger;
		searchStartPosition: searchStartInteger;
		yourself
]

{ #category : #comparing }
GtInsertTextCompletionAction >> = anObject [
	^ super = anObject and: [ self text = anObject text and: [ self position = anObject position ] ]
]

{ #category : #private }
GtInsertTextCompletionAction >> addPreviewAttributeForText: aString at: anInteger on: aCompletionController [
	(aCompletionController text from: (anInteger max: 1) to: anInteger)
		attributes: { (GtPreviewCompletionAttribute for: aString) }
]

{ #category : #testing }
GtInsertTextCompletionAction >> affectsText [
	^ super affectsText or: [ text notEmpty ]
]

{ #category : #private }
GtInsertTextCompletionAction >> clearPreviewAttributesOn: aCompletionController [
	aCompletionController text clearAttributes: [ :attr | attr class = GtPreviewCompletionAttribute ]
]

{ #category : #executing }
GtInsertTextCompletionAction >> finishCompletionOn: aCompletionController moveCursor: aBoolean [
	self clearPreviewAttributesOn: aCompletionController.
	self insert: text at: position on: aCompletionController.
	aBoolean
		ifFalse: [ ^ self ].
	self moveCursorOn: aCompletionController
]

{ #category : #private }
GtInsertTextCompletionAction >> fromIndex [
	^ searchStartPosition
]

{ #category : #printing }
GtInsertTextCompletionAction >> gtDisplayOn: aStream [
	super printOn: aStream.
	aStream 
		nextPut: $(;
		nextPutAll: self label;
		nextPutAll: ', ';
		nextPutAll: self text;
		nextPut: $).
]

{ #category : #comparing }
GtInsertTextCompletionAction >> hash [
	^ super hash bitXor: (text hash bitXor: position hash)
]

{ #category : #testing }
GtInsertTextCompletionAction >> isEmpty [
	^ text isEmpty
]

{ #category : #testing }
GtInsertTextCompletionAction >> isInsertion [
	^ true
]

{ #category : #executing }
GtInsertTextCompletionAction >> moveCursorOn: aCompletionController [
	aCompletionController textEditor moveCursorTo: position + text size
]

{ #category : #accessing }
GtInsertTextCompletionAction >> position [
	^ position
]

{ #category : #'initialize-release' }
GtInsertTextCompletionAction >> position: anInteger [
	position := anInteger
]

{ #category : #executing }
GtInsertTextCompletionAction >> previewOn: aCompletionController [
	text isEmpty
		ifTrue: [ ^ self ].
	self addPreviewAttributeForText: text at: position on: aCompletionController
]

{ #category : #accessing }
GtInsertTextCompletionAction >> searchStartPosition [
	^ searchStartPosition
]

{ #category : #'initialize-release' }
GtInsertTextCompletionAction >> searchStartPosition: anInteger [
	searchStartPosition := anInteger
]

{ #category : #accessing }
GtInsertTextCompletionAction >> text [
	^ text
]

{ #category : #'initialize-release' }
GtInsertTextCompletionAction >> text: aString [
	text := aString
]

{ #category : #private }
GtInsertTextCompletionAction >> toIndex [
	^ position + text size
]

{ #category : #translating }
GtInsertTextCompletionAction >> translateBy: anIndex [
	super translateBy: anIndex.
	position := position + anIndex.
	searchStartPosition := searchStartPosition + anIndex
]

{ #category : #executing }
GtInsertTextCompletionAction >> undoDrillDownOn: aCompletionController [
	text isEmpty
		ifFalse: [ self delete: position to: position + text size on: aCompletionController ].
	aCompletionController textEditor moveCursorTo: position
]

{ #category : #executing }
GtInsertTextCompletionAction >> undoPreviewOn: aCompletionController [
	self clearPreviewAttributesOn: aCompletionController
]
