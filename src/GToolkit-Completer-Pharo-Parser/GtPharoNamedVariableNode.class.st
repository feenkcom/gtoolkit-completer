Class {
	#name : #GtPharoNamedVariableNode,
	#superclass : #GtPharoVariableNode,
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoNamedVariableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNamedVariable: self
]
