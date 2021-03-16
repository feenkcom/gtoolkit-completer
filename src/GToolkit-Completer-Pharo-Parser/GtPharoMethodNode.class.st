Class {
	#name : #GtPharoMethodNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'pattern',
		'body'
	],
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoMethodNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitMethod: self
]

{ #category : #generated }
GtPharoMethodNode >> body [
	^ body
]

{ #category : #generated }
GtPharoMethodNode >> body: aGtPharoSequenceNode [
	self body notNil
		ifTrue: [ self body parent: nil ].
	body := aGtPharoSequenceNode.
	self body notNil
		ifTrue: [ self body parent: self ]
]

{ #category : #testing }
GtPharoMethodNode >> isMethod [
	^ true
]

{ #category : #accessing }
GtPharoMethodNode >> methodNode [
	^ self
]

{ #category : #generated }
GtPharoMethodNode >> nodeVariables [
	^ #(#pattern #body)
]

{ #category : #generated }
GtPharoMethodNode >> pattern [
	^ pattern
]

{ #category : #generated }
GtPharoMethodNode >> pattern: aGtPharoMethodPatternNode [
	self pattern notNil
		ifTrue: [ self pattern parent: nil ].
	pattern := aGtPharoMethodPatternNode.
	self pattern notNil
		ifTrue: [ self pattern parent: self ]
]

{ #category : #accessing }
GtPharoMethodNode >> pragmas [
	^ self body pragmas
]

{ #category : #accessing }
GtPharoMethodNode >> selector [
	"Return a method selector if method pattern parsing was successful or nil otherwise.
	Consider using #selectorDo: instead, as it does not return nil"

	self selectorDo: [ :aSymbol | ^ aSymbol ].
	^ nil
]

{ #category : #accessing }
GtPharoMethodNode >> selectorDo: aBlock [
	"Evaluate a block with a parsed method selector if method pattern is not erroneous"

	pattern isErrorNode
		ifFalse: [ aBlock value: pattern selector ]
]

{ #category : #accessing }
GtPharoMethodNode >> variables [
	^ pattern variables
]
