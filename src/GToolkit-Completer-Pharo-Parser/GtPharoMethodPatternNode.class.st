Class {
	#name : #GtPharoMethodPatternNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'selectorParts',
		'variables'
	],
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoMethodPatternNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitMethodPattern: self
]

{ #category : #generated }
GtPharoMethodPatternNode >> compositeNodeVariables [
	^ #(#variables)
]

{ #category : #generated }
GtPharoMethodPatternNode >> compositeTokenVariables [
	^ #(#selectorParts)
]

{ #category : #'generated-initialize-release' }
GtPharoMethodPatternNode >> initialize [
	super initialize.
	selectorParts := OrderedCollection new: 2.
	variables := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoMethodPatternNode >> selectorParts [
	^ selectorParts
]

{ #category : #generated }
GtPharoMethodPatternNode >> selectorParts: anOrderedCollection [
	selectorParts := anOrderedCollection
]

{ #category : #generated }
GtPharoMethodPatternNode >> variables [
	^ variables
]

{ #category : #generated }
GtPharoMethodPatternNode >> variables: anOrderedCollection [
	self setParents: self variables to: nil.
	variables := anOrderedCollection.
	self setParents: self variables to: self
]
