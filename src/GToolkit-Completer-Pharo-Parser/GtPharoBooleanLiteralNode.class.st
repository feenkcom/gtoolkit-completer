Class {
	#name : #GtPharoBooleanLiteralNode,
	#superclass : #GtPharoLiteralNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoBooleanLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitBooleanLiteral: self
]

{ #category : #accessing }
GtPharoBooleanLiteralNode >> literalValue [

	^ self value value = 'true'
		ifTrue: [ true ]
		ifFalse: [ false ]
]

{ #category : #generated }
GtPharoBooleanLiteralNode >> tokenVariables [
	^ #(#value)
]

{ #category : #generated }
GtPharoBooleanLiteralNode >> value [
	^ value
]

{ #category : #generated }
GtPharoBooleanLiteralNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
