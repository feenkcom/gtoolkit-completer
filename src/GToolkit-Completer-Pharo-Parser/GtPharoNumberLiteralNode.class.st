Class {
	#name : #GtPharoNumberLiteralNode,
	#superclass : #GtPharoLiteralNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoNumberLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNumberLiteral: self
]

{ #category : #accessing }
GtPharoNumberLiteralNode >> literalValue [
	^ Number
		readFrom: self value value
		ifFail: [ 0 ]
]

{ #category : #generated }
GtPharoNumberLiteralNode >> tokenVariables [
	^ #(#value)
]

{ #category : #generated }
GtPharoNumberLiteralNode >> value [
	^ value
]

{ #category : #generated }
GtPharoNumberLiteralNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
