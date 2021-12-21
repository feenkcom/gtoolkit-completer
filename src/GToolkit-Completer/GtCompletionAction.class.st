Class {
	#name : #GtCompletionAction,
	#superclass : #Object,
	#instVars : [
		'partial',
		'displayText'
	],
	#category : #'GToolkit-Completer-Actions'
}

{ #category : #'instance creation' }
GtCompletionAction class >> labeled: aString [
	^ self new
		label: aString;
		yourself
]

{ #category : #comparing }
GtCompletionAction >> = anObject [
	^ self class = anObject class and: [ self label = anObject label ]
]

{ #category : #testing }
GtCompletionAction >> affectsText [
	^ partial
]

{ #category : #'private-text modification' }
GtCompletionAction >> delete: from to: to on: aCompletionController [
	aCompletionController textEditor deleter
		from: from to: to;
		delete
]

{ #category : #displaying }
GtCompletionAction >> displayText [
	^ displayText
]

{ #category : #executing }
GtCompletionAction >> drillDownOn: aCompletionController [
	self finishCompletionOn: aCompletionController moveCursor: true
]

{ #category : #executing }
GtCompletionAction >> finishCompletionOn: aCompletionController moveCursor: aBoolean [
]

{ #category : #comparing }
GtCompletionAction >> hash [
	^ self class hash bitXor: self label hash
]

{ #category : #'initialize-release' }
GtCompletionAction >> initialize [
	super initialize.
	partial := false
]

{ #category : #'private-text modification' }
GtCompletionAction >> insert: aString at: anInteger on: aCompletionController [
	aString isEmpty
		ifTrue: [ ^ self ].
	aCompletionController textEditor inserter
		at: anInteger;
		string: aString;
		insert
]

{ #category : #testing }
GtCompletionAction >> isEmpty [
	^ false
]

{ #category : #testing }
GtCompletionAction >> isPartial [
	^ partial
]

{ #category : #accessing }
GtCompletionAction >> label [
	^ displayText asString
]

{ #category : #'initialize-release' }
GtCompletionAction >> label: aString [
	displayText := aString asRopedText
]

{ #category : #'initialize-release' }
GtCompletionAction >> partial: aBoolean [
	partial := aBoolean
]

{ #category : #executing }
GtCompletionAction >> previewOn: aCompletionController [
	self subclassResponsibility
]

{ #category : #accessing }
GtCompletionAction >> searchStartPosition [
	^ nil
]

{ #category : #translating }
GtCompletionAction >> translateBy: anIndex [
]

{ #category : #executing }
GtCompletionAction >> undoDrillDownOn: aCompletionController [
	
]

{ #category : #executing }
GtCompletionAction >> undoPreviewOn: aCompletionController [
	self subclassResponsibility
]
