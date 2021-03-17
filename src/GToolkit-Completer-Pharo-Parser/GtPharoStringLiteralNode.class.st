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
GtPharoStringLiteralNode >> literalValue [
	| aString |
	aString := self value value.
	aString first = $'
		ifTrue: [ aString := (aString copyFrom: 2 to: aString size - 1)
			copyReplaceAll: '''''' with: '''' ].
	^ aString
]

{ #category : #accessing }
GtPharoStringLiteralNode >> string [
	^ self literalValue
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
