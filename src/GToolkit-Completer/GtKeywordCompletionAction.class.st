Class {
	#name : #GtKeywordCompletionAction,
	#superclass : #GtInsertTextCompletionAction,
	#instVars : [
		'endPosition',
		'parenIndex'
	],
	#category : 'GToolkit-Completer-Pharo'
}

{ #category : #private }
GtKeywordCompletionAction >> addKeywordsAndArgsOn: aCompletionController [
	| first |
	first := true.
	endPosition := position.
	self
		keywordsAndArgumentNamesDo: [ :keyword :arg | 
			first
				ifFalse: [ aCompletionController textEditor insertString: ' ' at: endPosition.
					endPosition := endPosition + 1 ].
			aCompletionController textEditor insertString: keyword , ' ' at: endPosition.
			endPosition := endPosition + keyword size + 1.
			aCompletionController textEditor insertString: arg at: endPosition.
			(aCompletionController text from: endPosition to: endPosition + arg size - 1)
				attributes: {GtCompletionPartAttribute new}.
			endPosition := endPosition + arg size.
			first := false ]
]

{ #category : #'initialize-release' }
GtKeywordCompletionAction >> addParenthesesBefore: anIndex [
	parenIndex := anIndex
]

{ #category : #private }
GtKeywordCompletionAction >> addParenthesesOn: aCompletionController [
	parenIndex isNil
		ifTrue: [ ^ self ].
	aCompletionController textEditor insertString: ')' at: endPosition.
	endPosition := endPosition + 1.
	aCompletionController textEditor insertString: '(' at: parenIndex - 1
]

{ #category : #private }
GtKeywordCompletionAction >> fromIndex [
	^ parenIndex isNil
		ifTrue: [ super fromIndex ]
		ifFalse: [ parenIndex ]
]

{ #category : #private }
GtKeywordCompletionAction >> highlightPreviewComponentOn: aCompletionController [
	endPosition <= position
		ifTrue: [ ^ self ].
	self addPreviewAttributes: aCompletionController text from: position + 1 to: endPosition.
	parenIndex notNil
		ifTrue: [ self addPreviewAttributes: aCompletionController text from: parenIndex to: parenIndex ]
]

{ #category : #private }
GtKeywordCompletionAction >> keywordsAndArgumentNamesDo: aBlock [
	text first = $:
		ifTrue: [ aBlock value: ':' value: '_' ].
	(text substrings: ':') do: [ :each | aBlock value: each , ':' value: '_' ]
]

{ #category : #executing }
GtKeywordCompletionAction >> moveCursorOn: aCompletionController [
	aCompletionController advanceCursorToNextUncompletedItem
]

{ #category : #executing }
GtKeywordCompletionAction >> previewOn: aCompletionController [
	self highlightSearchComponentOn: aCompletionController.
	self addKeywordsAndArgsOn: aCompletionController.
	self addParenthesesOn: aCompletionController.
	self highlightPreviewComponentOn: aCompletionController
]

{ #category : #private }
GtKeywordCompletionAction >> toIndex [
	^ endPosition
]

{ #category : #executing }
GtKeywordCompletionAction >> undoPreviewOn: aCompletionController [
	self removeAttributesFromText: aCompletionController text.
	parenIndex notNil
		ifTrue: [ aCompletionController textEditor delete: parenIndex - 1 to: parenIndex ].
	aCompletionController textEditor delete: position to: endPosition.
	aCompletionController textEditor cursor position: position
]
