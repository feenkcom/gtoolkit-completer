Class {
	#name : #GtCompletionAttachmentAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'element',
		'controller'
	],
	#category : 'GToolkit-Completer'
}

{ #category : #'instance creation' }
GtCompletionAttachmentAttribute class >> for: aCompletionController [
	^ self new
		controller: aCompletionController;
		yourself
]

{ #category : #accessing }
GtCompletionAttachmentAttribute >> controller: aCompletionController [
	controller := aCompletionController
]

{ #category : #accessing }
GtCompletionAttachmentAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	element := BlElement new.
	element size: 0 @ 0.
	element margin: (BlInsets top: 5).
	element when: BlElementAddedToParentEvent do: [ :evt | controller onAttached: element ].
	element when: BlElementRemovedFromSceneGraphEvent do: [ :evt | controller removePopupOnAnchorRemoved ].
	^ {element}
]

{ #category : #accessing }
GtCompletionAttachmentAttribute >> element [
	^ element
]

{ #category : #initialization }
GtCompletionAttachmentAttribute >> initialize [
	super initialize.
	self beAppend.
	self beNotOverwritableByStyler
]
