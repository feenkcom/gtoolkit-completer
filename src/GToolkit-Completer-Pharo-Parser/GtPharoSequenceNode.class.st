Class {
	#name : #GtPharoSequenceNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'periods',
		'statements',
		'leftBar',
		'variables',
		'rightBar'
	],
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoSequenceNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSequence: self
]

{ #category : #generated }
GtPharoSequenceNode >> compositeNodeVariables [
	^ #(#statements #variables)
]

{ #category : #generated }
GtPharoSequenceNode >> ignoredCompositeTokenVariables [
	^ #(#periods)
]

{ #category : #generated }
GtPharoSequenceNode >> ignoredTokenVariables [
	^ #(#leftBar #rightBar)
]

{ #category : #'generated-initialize-release' }
GtPharoSequenceNode >> initialize [
	super initialize.
	periods := OrderedCollection new: 2.
	statements := OrderedCollection new: 2.
	variables := OrderedCollection new: 2.
]

{ #category : #testing }
GtPharoSequenceNode >> isSequence [
	^ true
]

{ #category : #generated }
GtPharoSequenceNode >> leftBar [
	^ leftBar
]

{ #category : #generated }
GtPharoSequenceNode >> leftBar: aSmaCCToken [
	leftBar := aSmaCCToken
]

{ #category : #generated }
GtPharoSequenceNode >> periods [
	^ periods
]

{ #category : #generated }
GtPharoSequenceNode >> periods: anOrderedCollection [
	periods := anOrderedCollection
]

{ #category : #accessing }
GtPharoSequenceNode >> pragmas [
	^ #()
]

{ #category : #generated }
GtPharoSequenceNode >> rightBar [
	^ rightBar
]

{ #category : #generated }
GtPharoSequenceNode >> rightBar: aSmaCCToken [
	rightBar := aSmaCCToken
]

{ #category : #generated }
GtPharoSequenceNode >> statements [
	^ statements
]

{ #category : #generated }
GtPharoSequenceNode >> statements: anOrderedCollection [
	self setParents: self statements to: nil.
	statements := anOrderedCollection.
	self setParents: self statements to: self
]

{ #category : #generated }
GtPharoSequenceNode >> variables [
	^ variables
]

{ #category : #generated }
GtPharoSequenceNode >> variables: anOrderedCollection [
	self setParents: self variables to: nil.
	variables := anOrderedCollection.
	self setParents: self variables to: self
]
