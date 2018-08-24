Class {
	#name : #GtCompletionAction,
	#superclass : #Object,
	#instVars : [
		'label',
		'partial'
	],
	#category : #'GToolkit-Completer'
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

{ #category : #'private-text modification' }
GtCompletionAction >> delete: from to: to on: aCompletionController [
	aCompletionController textEditor deleter
		delete: from to: to;
		delete
]

{ #category : #displaying }
GtCompletionAction >> displayString [
	^ label
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
	^ self class hash bitXor: label hash
]

{ #category : #'initialize-release' }
GtCompletionAction >> initialize [
	super initialize.
	partial := false
]

{ #category : #'private-text modification' }
GtCompletionAction >> insert: aString at: anInteger on: aCompletionController [
	aCompletionController textEditor inserter
		insertString: aString at: anInteger;
		insert
]

{ #category : #testing }
GtCompletionAction >> isPartial [
	^ partial
]

{ #category : #accessing }
GtCompletionAction >> label [
	^ label
]

{ #category : #'initialize-release' }
GtCompletionAction >> label: aString [
	label := aString
]

{ #category : #'initialize-release' }
GtCompletionAction >> partial: aBoolean [
	partial := aBoolean
]

{ #category : #executing }
GtCompletionAction >> previewOn: aCompletionController [
	self subclassResponsibility
]

{ #category : #executing }
GtCompletionAction >> undoDrillDownOn: aCompletionController [
	
]

{ #category : #executing }
GtCompletionAction >> undoPreviewOn: aCompletionController [
	self subclassResponsibility
]
