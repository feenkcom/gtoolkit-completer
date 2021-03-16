Class {
	#name : #GtPharoByteArrayLiteralNode,
	#superclass : #GtPharoArrayLiteralNode,
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoByteArrayLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitByteArrayLiteral: self
]

{ #category : #accessing }
GtPharoByteArrayLiteralNode >> literalValue [
	^ self values collect: [ :eachValue | eachValue literalValue ] as: ByteArray
]
