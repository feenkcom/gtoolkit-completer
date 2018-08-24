Class {
	#name : #GtPharoAssignmentNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'variable',
		'assignmentToken',
		'value'
	],
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoAssignmentNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitAssignment: self
]

{ #category : #generated }
GtPharoAssignmentNode >> assignmentToken [
	^ assignmentToken
]

{ #category : #generated }
GtPharoAssignmentNode >> assignmentToken: aSmaCCToken [
	assignmentToken := aSmaCCToken
]

{ #category : #generated }
GtPharoAssignmentNode >> nodeVariables [
	^ #(#variable #value)
]

{ #category : #generated }
GtPharoAssignmentNode >> tokenVariables [
	^ #(#assignmentToken)
]

{ #category : #generated }
GtPharoAssignmentNode >> value [
	^ value
]

{ #category : #generated }
GtPharoAssignmentNode >> value: aGtPharoValueNode [
	self value notNil
		ifTrue: [ self value parent: nil ].
	value := aGtPharoValueNode.
	self value notNil
		ifTrue: [ self value parent: self ]
]

{ #category : #generated }
GtPharoAssignmentNode >> variable [
	^ variable
]

{ #category : #generated }
GtPharoAssignmentNode >> variable: aGtPharoVariableNode [
	self variable notNil
		ifTrue: [ self variable parent: nil ].
	variable := aGtPharoVariableNode.
	self variable notNil
		ifTrue: [ self variable parent: self ]
]
