Class {
	#name : #GtPharoProgramNode,
	#superclass : #SmaCCParseNode,
	#category : #'GToolkit-Completer-Pharo-Parser'
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

{ #category : #testing }
GtPharoProgramNode >> isLiteral [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isMessage [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isMethod [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isMethodPattern [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isVariable [
	^ false
]

{ #category : #accessing }
GtPharoProgramNode >> methodNode [
	^ parent ifNotNil: [ parent methodNode ]
]
