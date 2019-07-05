Class {
	#name : #GtPharoProgramNode,
	#superclass : #SmaCCParseNode,
	#category : 'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoProgramNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProgram: self
]

{ #category : #accessing }
GtPharoProgramNode >> findVariableNodeAt: anInteger [
	self
		nodesDo:
			[ :each | (each findVariableNodeAt: anInteger) ifNotNil: [ :node | ^ node ] ]
		andTokensDo: [ :each |  ]
		includeErrors: true.
	^ nil
]
