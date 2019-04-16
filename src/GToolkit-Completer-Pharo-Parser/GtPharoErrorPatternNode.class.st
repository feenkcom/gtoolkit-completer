Class {
	#name : #GtPharoErrorPatternNode,
	#superclass : #GtPharoMethodPatternNode,
	#instVars : [
		'smaccError'
	],
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoErrorPatternNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitErrorPattern: self
]

{ #category : #generated }
GtPharoErrorPatternNode >> nodeVariables [
	^ #(#smaccError)
]

{ #category : #generated }
GtPharoErrorPatternNode >> smaccError [
	^ smaccError
]

{ #category : #generated }
GtPharoErrorPatternNode >> smaccError: aSmaCCErrorNode [
	self smaccError notNil
		ifTrue: [ self smaccError parent: nil ].
	smaccError := aSmaCCErrorNode.
	self smaccError notNil
		ifTrue: [ self smaccError parent: self ]
]
