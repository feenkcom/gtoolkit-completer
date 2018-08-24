Class {
	#name : #GtPharoBlockNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'leftBracket',
		'colons',
		'variables',
		'bar',
		'body',
		'rightBracket'
	],
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoBlockNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitBlock: self
]

{ #category : #generated }
GtPharoBlockNode >> bar [
	^ bar
]

{ #category : #generated }
GtPharoBlockNode >> bar: aSmaCCToken [
	bar := aSmaCCToken
]

{ #category : #generated }
GtPharoBlockNode >> body [
	^ body
]

{ #category : #generated }
GtPharoBlockNode >> body: aGtPharoSequenceNode [
	self body notNil
		ifTrue: [ self body parent: nil ].
	body := aGtPharoSequenceNode.
	self body notNil
		ifTrue: [ self body parent: self ]
]

{ #category : #generated }
GtPharoBlockNode >> colons [
	^ colons
]

{ #category : #generated }
GtPharoBlockNode >> colons: anOrderedCollection [
	colons := anOrderedCollection
]

{ #category : #generated }
GtPharoBlockNode >> compositeNodeVariables [
	^ #(#variables)
]

{ #category : #generated }
GtPharoBlockNode >> ignoredCompositeTokenVariables [
	^ #(#colons #leftParens #rightParens)
]

{ #category : #generated }
GtPharoBlockNode >> ignoredTokenVariables [
	^ #(#leftBracket #rightBracket)
]

{ #category : #'generated-initialize-release' }
GtPharoBlockNode >> initialize [
	super initialize.
	colons := OrderedCollection new: 2.
	variables := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoBlockNode >> leftBracket [
	^ leftBracket
]

{ #category : #generated }
GtPharoBlockNode >> leftBracket: aSmaCCToken [
	leftBracket := aSmaCCToken
]

{ #category : #generated }
GtPharoBlockNode >> nodeVariables [
	^ #(#body)
]

{ #category : #generated }
GtPharoBlockNode >> rightBracket [
	^ rightBracket
]

{ #category : #generated }
GtPharoBlockNode >> rightBracket: aSmaCCToken [
	rightBracket := aSmaCCToken
]

{ #category : #generated }
GtPharoBlockNode >> tokenVariables [
	^ #(#bar)
]

{ #category : #generated }
GtPharoBlockNode >> variables [
	^ variables
]

{ #category : #generated }
GtPharoBlockNode >> variables: anOrderedCollection [
	self setParents: self variables to: nil.
	variables := anOrderedCollection.
	self setParents: self variables to: self
]
