Class {
	#name : #GtPharoBinaryMessageNode,
	#superclass : #GtPharoMessageNode,
	#instVars : [
		'selectorPart',
		'value'
	],
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoBinaryMessageNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitBinaryMessage: self
]

{ #category : #generated }
GtPharoBinaryMessageNode >> nodeVariables [
	^ #(#value)
]

{ #category : #generated }
GtPharoBinaryMessageNode >> selectorPart [
	^ selectorPart
]

{ #category : #generated }
GtPharoBinaryMessageNode >> selectorPart: aSmaCCToken [
	selectorPart := aSmaCCToken
]

{ #category : #generated }
GtPharoBinaryMessageNode >> tokenVariables [
	^ #(#selectorPart)
]

{ #category : #generated }
GtPharoBinaryMessageNode >> value [
	^ value
]

{ #category : #generated }
GtPharoBinaryMessageNode >> value: aGtPharoValueNode [
	self value notNil
		ifTrue: [ self value parent: nil ].
	value := aGtPharoValueNode.
	self value notNil
		ifTrue: [ self value parent: self ]
]
