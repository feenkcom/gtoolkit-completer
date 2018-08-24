Class {
	#name : #GtPharoSymbolLiteralNode,
	#superclass : #GtPharoLiteralNode,
	#instVars : [
		'value'
	],
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoSymbolLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSymbolLiteral: self
]

{ #category : #generated }
GtPharoSymbolLiteralNode >> tokenVariables [
	^ #(#value)
]

{ #category : #generated }
GtPharoSymbolLiteralNode >> value [
	^ value
]

{ #category : #generated }
GtPharoSymbolLiteralNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
