Class {
	#name : #GtPharoProgramNode,
	#superclass : #SmaCCParseNode,
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #'api - ast' }
GtPharoProgramNode class >> typeOf: aGtPharoProgramNode in: aClass [
	"Given a pharo ast node and a class find the return type of the node"

	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isSelf ]) 
		ifTrue: [ ^ aClass ].
	
	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isSuper ]) 
		ifTrue: [ ^ aClass ifNotNil: [ :class | class superclass ] ].
	
	aGtPharoProgramNode isLiteral
		ifTrue: [ ^ aGtPharoProgramNode value class ].

	(aGtPharoProgramNode isKindOf: GtPharoArrayNode)
		ifTrue: [ ^ {} class ].

	aGtPharoProgramNode isMessage
		ifTrue: [ aGtPharoProgramNode selector = #class
				ifTrue: [ ^ (self typeOf: aGtPharoProgramNode messageReceiver in: aClass)
						ifNotNil: [ :class | class class ] ].
			(#(new new:) includes: aGtPharoProgramNode selector)
				ifTrue: [ ^ (self typeOf: aGtPharoProgramNode messageReceiver in: aClass)
						ifNotNil: [ :class | class instanceSide ] ] ].

	"aGtPharoProgramNode isVariable
		ifTrue: [ aGtPharoProgramNode binding
				ifNotNil: [ :binding | 
					binding isLiteralVariable
						ifTrue: [ binding value ifNotNil: [ :object | ^ object class ] ].
					(binding isSpecialVariable and: [ binding isThisContext ])
						ifTrue: [ ^ Context ] ] ]."
	^ nil
]

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
