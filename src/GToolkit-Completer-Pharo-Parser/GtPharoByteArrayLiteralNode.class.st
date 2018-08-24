Class {
	#name : #GtPharoByteArrayLiteralNode,
	#superclass : #GtPharoArrayLiteralNode,
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoByteArrayLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitByteArrayLiteral: self
]
