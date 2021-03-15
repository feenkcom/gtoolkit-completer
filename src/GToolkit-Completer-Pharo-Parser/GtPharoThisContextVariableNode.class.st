Class {
	#name : #GtPharoThisContextVariableNode,
	#superclass : #GtPharoVariableNode,
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoThisContextVariableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitThisContextVariable: self
]
