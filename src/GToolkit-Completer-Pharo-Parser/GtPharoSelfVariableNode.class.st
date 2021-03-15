Class {
	#name : #GtPharoSelfVariableNode,
	#superclass : #GtPharoVariableNode,
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoSelfVariableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSelfVariable: self
]

{ #category : #testing }
GtPharoSelfVariableNode >> isSelf [
	^ true
]
