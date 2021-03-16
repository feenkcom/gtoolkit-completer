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
		
	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isThisContext ]) 
		ifTrue: [ ^ Context ].
	
	aGtPharoProgramNode isLiteral
		ifTrue: [ ^ aGtPharoProgramNode value class ].

	(aGtPharoProgramNode isKindOf: GtPharoArrayNode)
		ifTrue: [ ^ {} class ].

	aGtPharoProgramNode isMessageSend
		ifTrue: [
			aGtPharoProgramNode selector = #class
				ifTrue: [ ^ (self typeOf: aGtPharoProgramNode receiver in: aClass)
						ifNotNil: [ :class | class class ] ].
			(#(new new:) includes: aGtPharoProgramNode selector)
				ifTrue: [ ^ (self typeOf: aGtPharoProgramNode receiver in: aClass)
						ifNotNil: [ :class | class instanceSide ] ] ].

	aGtPharoProgramNode isVariable
		ifTrue: [			
			self environment
				at: aGtPharoProgramNode name value asSymbol
				ifPresent: [ :anObject |
					anObject ifNotNil: [ ^ anObject class ] ] ].
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

{ #category : #accessing }
GtPharoProgramNode >> implicitLocalVariables [
	| variables |
	variables := self localVariables.
	self topParent
		allNodesOfType: GtPharoVariableNode
		do: [ :each | 
			(each == self or: [ each isLocallyDefined ])
				ifFalse: [ variables add: each name value ] ].
	^ variables
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
GtPharoProgramNode >> isMessageSend [
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
GtPharoProgramNode >> localVariables [
	| variables |
	variables := GtPrefixTree new.
	self localVariablesInto: variables.
	^ variables
]

{ #category : #accessing }
GtPharoProgramNode >> localVariablesInto: aCollection [
	parent notNil
		ifTrue: [ parent localVariablesInto: aCollection ]
]

{ #category : #accessing }
GtPharoProgramNode >> methodNode [
	^ parent ifNotNil: [ parent methodNode ]
]
