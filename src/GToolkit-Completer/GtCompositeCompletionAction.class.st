Class {
	#name : #GtCompositeCompletionAction,
	#superclass : #GtCompletionAction,
	#instVars : [
		'actions'
	],
	#category : #'GToolkit-Completer-Actions'
}

{ #category : #comparing }
GtCompositeCompletionAction >> = anObject [
	^ super = anObject and: [ self actions = anObject actions ]
]

{ #category : #private }
GtCompositeCompletionAction >> actions [
	^ actions
]

{ #category : #actions }
GtCompositeCompletionAction >> addAction: aCompletionAction [
	actions add: aCompletionAction
]

{ #category : #testing }
GtCompositeCompletionAction >> affectsText [
	^ super affectsText or: [ actions anySatisfy: [ :each | each affectsText ] ]
]

{ #category : #executing }
GtCompositeCompletionAction >> drillDownOn: aCompletionController [
	actions do: [ :each | each drillDownOn: aCompletionController ]
]

{ #category : #executing }
GtCompositeCompletionAction >> finishCompletionOn: aCompletionController moveCursor: aBoolean [
	actions do: [ :each | each finishCompletionOn: aCompletionController moveCursor: aBoolean ]
]

{ #category : #comparing }
GtCompositeCompletionAction >> hash [
	^ super hash bitXor: self actions hash
]

{ #category : #'initialize-release' }
GtCompositeCompletionAction >> initialize [
	super initialize.
	actions := OrderedCollection new
]

{ #category : #testing }
GtCompositeCompletionAction >> isEmpty [
	^ actions allSatisfy: [ :each | each isEmpty ]
]

{ #category : #executing }
GtCompositeCompletionAction >> previewOn: aCompletionController [
	actions do: [ :each | each previewOn: aCompletionController ]
]

{ #category : #actions }
GtCompositeCompletionAction >> removeAction: aCompletionAction [
	actions remove: aCompletionAction ifAbsent: [  ]
]

{ #category : #translating }
GtCompositeCompletionAction >> translateBy: anIndex [
	super translateBy: anIndex.
	self actions do: [ :each | each translateBy: anIndex ]
]

{ #category : #executing }
GtCompositeCompletionAction >> undoDrillDownOn: aCompletionController [
	actions reverseDo: [ :each | each undoDrillDownOn: aCompletionController ]
]

{ #category : #executing }
GtCompositeCompletionAction >> undoPreviewOn: aCompletionController [
	actions reverseDo: [ :each | each undoPreviewOn: aCompletionController ]
]
