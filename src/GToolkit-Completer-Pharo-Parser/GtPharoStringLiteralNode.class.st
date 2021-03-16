Class {
	#name : #GtPharoStringLiteralNode,
	#superclass : #GtPharoLiteralNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoStringLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitStringLiteral: self
]

{ #category : #accessing }
GtPharoStringLiteralNode >> string [
	^ self value value
]

{ #category : #generated }
GtPharoStringLiteralNode >> tokenVariables [
	^ #(#value)
]

{ #category : #generated }
GtPharoStringLiteralNode >> value [
	^ value
]

{ #category : #generated }
GtPharoStringLiteralNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
