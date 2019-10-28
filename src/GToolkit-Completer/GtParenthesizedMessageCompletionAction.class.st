Class {
	#name : #GtParenthesizedMessageCompletionAction,
	#superclass : #GtInsertTextCompletionAction,
	#instVars : [
		'endPosition',
		'parenIndex'
	],
	#category : #'GToolkit-Completer-Pharo'
}

{ #category : #adding }
GtParenthesizedMessageCompletionAction >> addMessageAndArgsOn: aCompletionController [
	| first argLocations |
	first := true.
	endPosition := position.
	self hasParentheses
		ifTrue: [ self insert: ')' at: position on: aCompletionController.
			self insert: '(' at: parenIndex - 1 on: aCompletionController.
			endPosition := endPosition + 1 ].
	argLocations := OrderedCollection new.
	self
		messageAndArgumentNamesDo: [ :keyword :arg | 
			first
				ifFalse: [ self insert: ' ' at: endPosition on: aCompletionController.
					endPosition := endPosition + 1 ].
			self insert: keyword , ' ' at: endPosition on: aCompletionController.
			endPosition := endPosition + keyword size + 1.
			argLocations add: (endPosition + 1 to: endPosition + arg size).
			self insert: arg at: endPosition on: aCompletionController.
			endPosition := endPosition + arg size.
			first := false ].
	argLocations do: [ :each | (aCompletionController text from: each first to: each last) attributes: {GtCompletionPartAttribute new} ].
	self hasParentheses
		ifTrue: [ endPosition := endPosition + 1 ]
]

{ #category : #'initialize-release' }
GtParenthesizedMessageCompletionAction >> addParenthesesBefore: anIndex [
	parenIndex := anIndex
]

{ #category : #private }
GtParenthesizedMessageCompletionAction >> addParenthesesOn: aCompletionController [
	self hasParentheses
		ifFalse: [ ^ self ].
	self insert: ')' at: endPosition on: aCompletionController.
	endPosition := endPosition + 1.
	self insert: '(' at: parenIndex - 1 on: aCompletionController
]

{ #category : #private }
GtParenthesizedMessageCompletionAction >> addParenthesisAttributeOn: aCompletionController [
	self hasParentheses
		ifFalse: [ ^ self ].
	self addPreviewAttributeForText: '(' at: parenIndex - 1 on: aCompletionController
]

{ #category : #testing }
GtParenthesizedMessageCompletionAction >> affectsText [
	^ true
]

{ #category : #private }
GtParenthesizedMessageCompletionAction >> completedMessage [
	^ String
		streamContents: [ :stream | 
			| first |
			first := true.
			self
				messageAndArgumentNamesDo: [ :keyword :arg | 
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
GtParenthesizedMessageCompletionAction >> finishCompletionOn: aCompletionController moveCursor: aBoolean [
	self clearPreviewAttributesOn: aCompletionController.
	self addMessageAndArgsOn: aCompletionController.
	aBoolean
		ifFalse: [ ^ self ].
	self moveCursorOn: aCompletionController
]

{ #category : #private }
GtParenthesizedMessageCompletionAction >> fromIndex [
	^ self hasParentheses
		ifTrue: [ parenIndex ]
		ifFalse: [ super fromIndex ]
]

{ #category : #testing }
GtParenthesizedMessageCompletionAction >> hasParentheses [
	^ parenIndex notNil
]

{ #category : #enumerating }
GtParenthesizedMessageCompletionAction >> messageAndArgumentNamesDo: aBlock [
	self subclassResponsibility
]

{ #category : #executing }
GtParenthesizedMessageCompletionAction >> moveCursorOn: aCompletionController [
	aCompletionController textEditor moveCursorTo: position.
	aCompletionController moveCursorToNextUncompletedItem: 1
]

{ #category : #executing }
GtParenthesizedMessageCompletionAction >> previewOn: aCompletionController [
	self
		addPreviewAttributeForText: self completedMessage
		at: position
		on: aCompletionController.
	self addParenthesisAttributeOn: aCompletionController
]

{ #category : #private }
GtParenthesizedMessageCompletionAction >> toIndex [
	^ endPosition
]

{ #category : #translating }
GtParenthesizedMessageCompletionAction >> translateBy: anIndex [
	super translateBy: anIndex.
	parenIndex notNil
		ifTrue: [ parenIndex := parenIndex + anIndex ]
]
