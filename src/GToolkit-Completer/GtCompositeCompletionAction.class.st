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

{ #category : #accessing }
GtCompositeCompletionAction >> gtActionsFor: aView [ 
	<gtView>
	self actions ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'Actions';
		object: [ self actions ];
		view: #gtItemsFor:
]

{ #category : #printing }
GtCompositeCompletionAction >> gtDisplayOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self label;
		nextPut: $)
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

{ #category : #accessing }
GtCompositeCompletionAction >> searchStartPosition [
	actions
		do: [ :each | each searchStartPosition ifNotNil: [ :pos | ^ pos ] ].
	^ nil
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
