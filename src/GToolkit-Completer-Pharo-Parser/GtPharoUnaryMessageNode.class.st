Class {
	#name : #GtPharoUnaryMessageNode,
	#superclass : #GtPharoMessageNode,
	#instVars : [
		'selectorPart'
	],
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoUnaryMessageNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitUnaryMessage: self
]

{ #category : #generated }
GtPharoUnaryMessageNode >> selectorPart [
	^ selectorPart
]

{ #category : #generated }
GtPharoUnaryMessageNode >> selectorPart: aSmaCCToken [
	selectorPart := aSmaCCToken
]

{ #category : #generated }
GtPharoUnaryMessageNode >> tokenVariables [
	^ #(#selectorPart)
]
