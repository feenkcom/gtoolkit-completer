Class {
	#name : #GtPharoProgramNode,
	#superclass : #SmaCCParseNode,
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoProgramNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProgram: self
]
