Class {
	#name : #GtCompletionAttachmentAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'element',
		'controller'
	],
	#category : #'GToolkit-Completer-Attributes'
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
	element when: BlElementAddedToParentEvent do: [ :evt | controller onAttached: element ].
	
	"Removed following line to prevent autocomplete only on every other keystroke"
	"element when: BlElementRemovedFromSceneGraphEvent do: [ :evt | controller removePopupOnAnchorRemoved ]."
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
	self beNotOverwritableByStyler.
	self placeholderAlignment: #alignBottom.
	self shouldPropagate: false
]
