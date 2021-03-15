Class {
	#name : #GtPharoMethodNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'pattern',
		'body'
	],
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoMethodNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitMethod: self
]

{ #category : #generated }
GtPharoMethodNode >> body [
	^ body
]

{ #category : #generated }
GtPharoMethodNode >> body: aGtPharoSequenceNode [
	self body notNil
		ifTrue: [ self body parent: nil ].
	body := aGtPharoSequenceNode.
	self body notNil
		ifTrue: [ self body parent: self ]
]

{ #category : #testing }
GtPharoMethodNode >> isMethod [
	^ true
]

{ #category : #accessing }
GtPharoMethodNode >> methodNode [
	^ self
]

{ #category : #generated }
GtPharoMethodNode >> nodeVariables [
	^ #(#pattern #body)
]

{ #category : #generated }
GtPharoMethodNode >> pattern [
	^ pattern
]

{ #category : #generated }
GtPharoMethodNode >> pattern: aGtPharoMethodPatternNode [
	self pattern notNil
		ifTrue: [ self pattern parent: nil ].
	pattern := aGtPharoMethodPatternNode.
	self pattern notNil
		ifTrue: [ self pattern parent: self ]
]

{ #category : #accessing }
GtPharoMethodNode >> selector [
	^ pattern selector
]

{ #category : #accessing }
GtPharoMethodNode >> variables [
	^ pattern variables
]
