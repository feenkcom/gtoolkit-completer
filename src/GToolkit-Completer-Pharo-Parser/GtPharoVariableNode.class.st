Class {
	#name : #GtPharoVariableNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoVariableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitVariable: self
]

{ #category : #accessing }
GtPharoVariableNode >> findVariableNodeAt: anInteger [
	^ (anInteger between: self startPosition and: self stopPosition)
		ifTrue: [ self ]
]

{ #category : #testing }
GtPharoVariableNode >> isSelf [
	^ false
]

{ #category : #testing }
GtPharoVariableNode >> isSuper [
	^ false
]

{ #category : #testing }
GtPharoVariableNode >> isThisContext [
	^ false
]

{ #category : #testing }
GtPharoVariableNode >> isUndeclared [
	self isSelf
		ifTrue: [ ^ false ].
		
	self isSuper
		ifTrue: [ ^ false ].
		
	self isThisContext
		ifTrue: [ ^ false ].

	^ (self localVariables includes: self variableName) not
		and: [ (self class environment includesKey: self variableName) not ]
]

{ #category : #testing }
GtPharoVariableNode >> isVariable [
	^ true
]

{ #category : #generated }
GtPharoVariableNode >> name [
	^ name
]

{ #category : #generated }
GtPharoVariableNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
GtPharoVariableNode >> tokenVariables [
	^ #(#name)
]

{ #category : #accessing }
GtPharoVariableNode >> variableName [
	"Return the variable name as a symbol"
	<return: #Symbol>

	^ self name value asSymbol
]
