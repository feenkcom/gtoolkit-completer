Class {
	#name : #GtPharoNilLiteralNode,
	#superclass : #GtPharoLiteralNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoNilLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNilLiteral: self
]

{ #category : #accessing }
GtPharoNilLiteralNode >> literalValue [
	^ nil
]

{ #category : #generated }
GtPharoNilLiteralNode >> tokenVariables [
	^ #(#value)
]

{ #category : #generated }
GtPharoNilLiteralNode >> value [
	^ value
]

{ #category : #generated }
GtPharoNilLiteralNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
