"
GtReplaceSubtextCompletionAction replaces the text that triggered the completion with the supplied text.

By default the cursor is positioned at the end of the replacement text, a cursor offset may be supplied to position the cursor within or beyond the replacement text.
"
Class {
	#name : #GtReplaceSubtextCompletionAction,
	#superclass : #GtCompletionAction,
	#instVars : [
		'text',
		'end',
		'start',
		'cursorOffset'
	],
	#category : #'GToolkit-Completer-Actions'
}

{ #category : #comparing }
GtReplaceSubtextCompletionAction >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	super = anObject ifFalse: [ ^ false ].
	^ text = anObject text and:
		[ cursorOffset = anObject cursorOffset and: 
		[ start = anObject start and: 
		[ end = anObject end ] ] ]
]

{ #category : #testing }
GtReplaceSubtextCompletionAction >> affectsText [
	^ self text isNotNil and: [ start <= end ]
]

{ #category : #accessing }
GtReplaceSubtextCompletionAction >> cursorOffset [

	^ cursorOffset
]

{ #category : #accessing }
GtReplaceSubtextCompletionAction >> cursorOffset: anObject [

	cursorOffset := anObject
]

{ #category : #accessing }
GtReplaceSubtextCompletionAction >> end [

	^ end
]

{ #category : #accessing }
GtReplaceSubtextCompletionAction >> end: anObject [

	end := anObject
]

{ #category : #executing }
GtReplaceSubtextCompletionAction >> finishCompletionOn: aCompletionController moveCursor: aBoolean [

	aCompletionController textEditor deleter
		from: start to: end;
		delete.
	aCompletionController textEditor inserter
		string: self text;
		at: start;
		insert.
	aCompletionController textEditor moveCursorTo: start + self text size + cursorOffset.
]

{ #category : #comparing }
GtReplaceSubtextCompletionAction >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: 
		(text hash bitXor: (cursorOffset hash bitXor: (start hash bitXor: end hash)))
]

{ #category : #initialization }
GtReplaceSubtextCompletionAction >> initialize [

	super initialize.
	cursorOffset := 0.
]

{ #category : #accessing }
GtReplaceSubtextCompletionAction >> partial [

	^ partial
]

{ #category : #executing }
GtReplaceSubtextCompletionAction >> previewOn: aCompletionController [
]

{ #category : #accessing }
GtReplaceSubtextCompletionAction >> start [

	^ start
]

{ #category : #accessing }
GtReplaceSubtextCompletionAction >> start: anObject [

	start := anObject
]

{ #category : #accessing }
GtReplaceSubtextCompletionAction >> text [
	^ text
]

{ #category : #accessing }
GtReplaceSubtextCompletionAction >> text: anObject [
	text := anObject
]

{ #category : #executing }
GtReplaceSubtextCompletionAction >> undoPreviewOn: aCompletionController [
]
