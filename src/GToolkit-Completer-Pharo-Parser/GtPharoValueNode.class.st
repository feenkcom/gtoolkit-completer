Class {
	#name : #GtPharoValueNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'leftParens',
		'rightParens'
	],
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoValueNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitValue: self
]

{ #category : #generated }
GtPharoValueNode >> ignoredCompositeTokenVariables [
	^ #(#leftParens #rightParens)
]

{ #category : #'generated-initialize-release' }
GtPharoValueNode >> initialize [
	super initialize.
	leftParens := OrderedCollection new: 2.
	rightParens := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoValueNode >> leftParens [
	^ leftParens
]

{ #category : #generated }
GtPharoValueNode >> leftParens: anOrderedCollection [
	leftParens := anOrderedCollection
]

{ #category : #generated }
GtPharoValueNode >> rightParens [
	^ rightParens
]

{ #category : #generated }
GtPharoValueNode >> rightParens: anOrderedCollection [
	rightParens := anOrderedCollection
]
