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
				ifFalse: [ self insert: ' ' at: endPosition on: aCompletionController.
					endPosition := endPosition + 1 ].
			self insert: keyword , ' ' at: endPosition on: aCompletionController.
			endPosition := endPosition + keyword size + 1.
			self insert: arg at: endPosition on: aCompletionController.
			(aCompletionController text from: endPosition to: endPosition + arg size - 1) attributes: {GtCompletionPartAttribute new}.
			endPosition := endPosition + arg size.
			first := false ]
]

{ #category : #'initialize-release' }
GtKeywordCompletionAction >> addParenthesesBefore: anIndex [
	parenIndex := anIndex
]

{ #category : #private }
GtKeywordCompletionAction >> addParenthesesOn: aCompletionController [
	self hasParentheses
		ifFalse: [ ^ self ].
	self insert: ')' at: endPosition on: aCompletionController.
	endPosition := endPosition + 1.
	self insert: '(' at: parenIndex - 1 on: aCompletionController
]

{ #category : #private }
GtKeywordCompletionAction >> addParenthesisAttributeOn: aCompletionController [
	self hasParentheses
		ifFalse: [ ^ self ].
	self addPreviewAttributeForText: '(' at: parenIndex - 1 on: aCompletionController
]

{ #category : #private }
GtKeywordCompletionAction >> clearPreviewAttributesOn: aCompletionController [
	super clearPreviewAttributesOn: aCompletionController.
	self hasParentheses
		ifTrue: [ self clearPreviewAttributesOn: aCompletionController at: parenIndex - 1 ]
]

{ #category : #private }
GtKeywordCompletionAction >> completedMessage [
	^ String
		streamContents: [ :stream | 
			| first |
			first := true.
			self
				keywordsAndArgumentNamesDo: [ :keyword :arg | 
					first
						ifTrue: [ first := false ]
						ifFalse: [ stream space ].
					stream
						nextPutAll: keyword;
						space;
						nextPutAll: arg ].
			self hasParentheses
				ifTrue: [ stream nextPut: $) ] ]
]

{ #category : #executing }
GtKeywordCompletionAction >> finishCompletionOn: aCompletionController moveCursor: aBoolean [
	self clearPreviewAttributesOn: aCompletionController.
	self addKeywordsAndArgsOn: aCompletionController.
	self addParenthesesOn: aCompletionController.
	aBoolean
		ifFalse: [ ^ self ].
	self moveCursorOn: aCompletionController
]

{ #category : #private }
GtKeywordCompletionAction >> fromIndex [
	^ self hasParentheses
		ifTrue: [ parenIndex ]
		ifFalse: [ super fromIndex ]
]

{ #category : #testing }
GtKeywordCompletionAction >> hasParentheses [
	^ parenIndex notNil
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
	self addPreviewAttributeForText: self completedMessage at: position on: aCompletionController.
	self addParenthesisAttributeOn: aCompletionController
]

{ #category : #private }
GtKeywordCompletionAction >> toIndex [
	^ endPosition
]
