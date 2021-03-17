Class {
	#name : #GtPharoKeywordMessageNode,
	#superclass : #GtPharoMessageNode,
	#instVars : [
		'selectorParts',
		'values'
	],
	#category : #'GToolkit-Completer-Pharo-Parser'
}

{ #category : #generated }
GtPharoKeywordMessageNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitKeywordMessage: self
]

{ #category : #accessing }
GtPharoKeywordMessageNode >> arguments [
	^ self values
]

{ #category : #generated }
GtPharoKeywordMessageNode >> compositeNodeVariables [
	^ #(#values)
]

{ #category : #generated }
GtPharoKeywordMessageNode >> compositeTokenVariables [
	^ #(#selectorParts)
]

{ #category : #'generated-initialize-release' }
GtPharoKeywordMessageNode >> initialize [
	super initialize.
	selectorParts := OrderedCollection new: 2.
	values := OrderedCollection new: 2.
]

{ #category : #testing }
GtPharoKeywordMessageNode >> isKeyword [
	^ true
]

{ #category : #accessing }
GtPharoKeywordMessageNode >> selector [
	^ (String streamContents: [ :stream | self selectorParts do: [ :each | stream nextPutAll: each value ] ]) asSymbol
]

{ #category : #generated }
GtPharoKeywordMessageNode >> selectorParts [
	^ selectorParts
]

{ #category : #generated }
GtPharoKeywordMessageNode >> selectorParts: anOrderedCollection [
	selectorParts := anOrderedCollection
]

{ #category : #generated }
GtPharoKeywordMessageNode >> values [
	^ values
]

{ #category : #generated }
GtPharoKeywordMessageNode >> values: anOrderedCollection [
	self setParents: self values to: nil.
	values := anOrderedCollection.
	self setParents: self values to: self
]
