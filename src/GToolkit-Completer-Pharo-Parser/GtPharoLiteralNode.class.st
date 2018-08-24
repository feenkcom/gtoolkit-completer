Class {
	#name : #GtPharoLiteralNode,
	#superclass : #GtPharoValueNode,
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLiteral: self
]
