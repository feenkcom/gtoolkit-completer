Class {
	#name : #GtPharoBlockErrorNode,
	#superclass : #GtPharoBlockNode,
	#instVars : [
		'smaccError'
	],
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoBlockErrorNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitBlockError: self
]

{ #category : #generated }
GtPharoBlockErrorNode >> nodeVariables [
	^ #(#smaccError #body)
]

{ #category : #generated }
GtPharoBlockErrorNode >> smaccError [
	^ smaccError
]

{ #category : #generated }
GtPharoBlockErrorNode >> smaccError: aSmaCCError [
	self smaccError notNil
		ifTrue: [ self smaccError parent: nil ].
	smaccError := aSmaCCError.
	self smaccError notNil
		ifTrue: [ self smaccError parent: self ]
]
