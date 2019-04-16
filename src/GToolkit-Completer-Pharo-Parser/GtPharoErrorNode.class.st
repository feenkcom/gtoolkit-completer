Class {
	#name : #GtPharoErrorNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'smaccError'
	],
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoErrorNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitError: self
]

{ #category : #generated }
GtPharoErrorNode >> nodeVariables [
	^ #(#smaccError)
]

{ #category : #generated }
GtPharoErrorNode >> smaccError [
	^ smaccError
]

{ #category : #generated }
GtPharoErrorNode >> smaccError: aSmaCCErrorNode [
	self smaccError notNil
		ifTrue: [ self smaccError parent: nil ].
	smaccError := aSmaCCErrorNode.
	self smaccError notNil
		ifTrue: [ self smaccError parent: self ]
]
