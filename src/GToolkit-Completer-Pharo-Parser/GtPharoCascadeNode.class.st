Class {
	#name : #GtPharoCascadeNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'receiver',
		'messages',
		'semicolons'
	],
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoCascadeNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitCascade: self
]

{ #category : #generated }
GtPharoCascadeNode >> compositeNodeVariables [
	^ #(#messages)
]

{ #category : #generated }
GtPharoCascadeNode >> ignoredCompositeTokenVariables [
	^ #(#semicolons #leftParens #rightParens)
]

{ #category : #'generated-initialize-release' }
GtPharoCascadeNode >> initialize [
	super initialize.
	messages := OrderedCollection new: 2.
	semicolons := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoCascadeNode >> messages [
	^ messages
]

{ #category : #generated }
GtPharoCascadeNode >> messages: anOrderedCollection [
	self setParents: self messages to: nil.
	messages := anOrderedCollection.
	self setParents: self messages to: self
]

{ #category : #generated }
GtPharoCascadeNode >> nodeVariables [
	^ #(#receiver)
]

{ #category : #generated }
GtPharoCascadeNode >> receiver [
	^ receiver
]

{ #category : #generated }
GtPharoCascadeNode >> receiver: aGtPharoValueNode [
	self receiver notNil
		ifTrue: [ self receiver parent: nil ].
	receiver := aGtPharoValueNode.
	self receiver notNil
		ifTrue: [ self receiver parent: self ]
]

{ #category : #generated }
GtPharoCascadeNode >> semicolons [
	^ semicolons
]

{ #category : #generated }
GtPharoCascadeNode >> semicolons: anOrderedCollection [
	semicolons := anOrderedCollection
]
