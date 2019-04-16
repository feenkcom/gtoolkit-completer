Class {
	#name : #GtPharoPragmaErrorNode,
	#superclass : #GtPharoPragmaNode,
	#instVars : [
		'smaccError'
	],
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoPragmaErrorNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPragmaError: self
]

{ #category : #generated }
GtPharoPragmaErrorNode >> nodeVariables [
	^ #(#smaccError)
]

{ #category : #generated }
GtPharoPragmaErrorNode >> smaccError [
	^ smaccError
]

{ #category : #generated }
GtPharoPragmaErrorNode >> smaccError: aSmaCCErrorNode [
	self smaccError notNil
		ifTrue: [ self smaccError parent: nil ].
	smaccError := aSmaCCErrorNode.
	self smaccError notNil
		ifTrue: [ self smaccError parent: self ]
]
