Class {
	#name : #GtPharoVariableNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'name'
	],
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoVariableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitVariable: self
]

{ #category : #generated }
GtPharoVariableNode >> name [
	^ name
]

{ #category : #generated }
GtPharoVariableNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
GtPharoVariableNode >> tokenVariables [
	^ #(#name)
]
