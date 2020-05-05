Class {
	#name : #GtPharoUnaryMessageNode,
	#superclass : #GtPharoMessageNode,
	#instVars : [
		'selectorPart'
	],
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoUnaryMessageNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitUnaryMessage: self
]

{ #category : #accessing }
GtPharoUnaryMessageNode >> selector [
	^ self selectorPart value asSymbol
]

{ #category : #generated }
GtPharoUnaryMessageNode >> selectorPart [
	^ selectorPart
]

{ #category : #generated }
GtPharoUnaryMessageNode >> selectorPart: aSmaCCToken [
	selectorPart := aSmaCCToken
]

{ #category : #accessing }
GtPharoUnaryMessageNode >> selectorParts [
	^ {selectorPart}
]

{ #category : #generated }
GtPharoUnaryMessageNode >> tokenVariables [
	^ #(#selectorPart)
]
