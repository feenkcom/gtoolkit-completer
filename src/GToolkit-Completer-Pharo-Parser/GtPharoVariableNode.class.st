Class {
	#name : #GtPharoVariableNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoVariableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitVariable: self
]

{ #category : #accessing }
GtPharoVariableNode >> findVariableNodeAt: anInteger [
	^ (anInteger between: self startPosition and: self stopPosition)
		ifTrue: [ self ]
]

{ #category : #testing }
GtPharoVariableNode >> isVariable [
	^ true
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
