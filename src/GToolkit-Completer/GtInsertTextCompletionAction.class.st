Class {
	#name : #GtInsertTextCompletionAction,
	#superclass : #GtCompletionAction,
	#instVars : [
		'text',
		'position',
		'searchStartPosition'
	],
	#category : 'GToolkit-Completer'
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

{ #category : #executing }
GtInsertTextCompletionAction >> finishCompletionOn: aCompletionController moveCursor: aBoolean [
	self removeAttributesFromText: aCompletionController text.
	aBoolean
		ifFalse: [ ^ self ].
	self moveCursorOn: aCompletionController
]

{ #category : #private }
GtInsertTextCompletionAction >> fromIndex [
	^ searchStartPosition
]

{ #category : #comparing }
GtInsertTextCompletionAction >> hash [
	^ super hash bitXor: (text hash bitXor: position hash)
]

{ #category : #private }
GtInsertTextCompletionAction >> highlightPreviewComponentOn: aCompletionController [
	self text size <= 0
		ifTrue: [ ^ self ].
	self addPreviewAttributes: aCompletionController text from: position + 1 to: position + self text size
]

{ #category : #private }
GtInsertTextCompletionAction >> highlightSearchComponentOn: aCompletionController [
	searchStartPosition > position
		ifTrue: [ ^ self ].
	self addSearchAttributes: aCompletionController text from: searchStartPosition to: position
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
	aCompletionController textEditor insertString: text at: position.
	self highlightSearchComponentOn: aCompletionController.
	self highlightPreviewComponentOn: aCompletionController
]

{ #category : #private }
GtInsertTextCompletionAction >> removeAttributesFromText: aText [
	self removeAttributes: aText from: self fromIndex to: self toIndex
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

{ #category : #executing }
GtInsertTextCompletionAction >> undoDrillDownOn: aCompletionController [
	aCompletionController textEditor moveCursorTo: position
]

{ #category : #executing }
GtInsertTextCompletionAction >> undoPreviewOn: aCompletionController [
	self removeAttributesFromText: aCompletionController text.
	text isEmpty
		ifFalse: [ aCompletionController textEditor delete: position to: position + text size ].
	aCompletionController textEditor moveCursorTo: position
]
