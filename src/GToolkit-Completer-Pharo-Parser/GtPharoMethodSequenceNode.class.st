Class {
	#name : #GtPharoMethodSequenceNode,
	#superclass : #GtPharoSequenceNode,
	#instVars : [
		'pragmas'
	],
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoMethodSequenceNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitMethodSequence: self
]

{ #category : #generated }
GtPharoMethodSequenceNode >> compositeNodeVariables [
	^ #(#pragmas #statements #variables)
]

{ #category : #'generated-initialize-release' }
GtPharoMethodSequenceNode >> initialize [
	super initialize.
	pragmas := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoMethodSequenceNode >> pragmas [
	^ pragmas
]

{ #category : #generated }
GtPharoMethodSequenceNode >> pragmas: anOrderedCollection [
	self setParents: self pragmas to: nil.
	pragmas := anOrderedCollection.
	self setParents: self pragmas to: self
]
