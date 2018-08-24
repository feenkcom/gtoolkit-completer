Class {
	#name : #GtCompletionAction,
	#superclass : #Object,
	#instVars : [
		'label',
		'partial'
	],
	#classVars : [
		'PreviewAttribute',
		'SearchAttribute'
	],
	#category : 'GToolkit-Completer'
}

{ #category : #'class initialization' }
GtCompletionAction class >> initialize [
	PreviewAttribute := BrTextBackgroundAttribute paint: Color yellow.
	PreviewAttribute beNotOverwritableByStyler.
	SearchAttribute := BrTextBackgroundAttribute paint: Color lightGreen.
	SearchAttribute beNotOverwritableByStyler
]

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

{ #category : #'private-attributes' }
GtCompletionAction >> addPreviewAttributes: aText from: startIndex to: endIndex [
	(aText from: (startIndex min: aText size) to: (endIndex min: aText size)) attributes: {PreviewAttribute}
]

{ #category : #'private-attributes' }
GtCompletionAction >> addSearchAttributes: aText from: startIndex to: endIndex [
	(aText from: (startIndex min: aText size) to: (endIndex min: aText size)) attributes: {SearchAttribute}
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

{ #category : #'private-attributes' }
GtCompletionAction >> removeAttributes: aText from: startIndex to: endIndex [
	aText
		clearAttributes: (startIndex min: aText size)
		to: (endIndex min: aText size)
		if: [ :attr | attr == SearchAttribute or: [ attr == PreviewAttribute ] ]
]

{ #category : #executing }
GtCompletionAction >> undoDrillDownOn: aCompletionController [
	
]

{ #category : #executing }
GtCompletionAction >> undoPreviewOn: aCompletionController [
	self subclassResponsibility
]
