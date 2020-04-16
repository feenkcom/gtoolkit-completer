Class {
	#name : #GtRenamePreviewAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'text',
		'originalAttributes',
		'element',
		'renameAction'
	],
	#category : #'GToolkit-Completer'
}

{ #category : #accessing }
GtRenamePreviewAttribute >> action: aRenameAction [
	renameAction := aRenameAction
]

{ #category : #accessing }
GtRenamePreviewAttribute >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	| editor |
	element := BrEditorElement new.
	element
		margin:
			(BlInsets
				top: -2
				left: 0
				bottom: 2
				right: 0).
	element padding: (BlInsets top: 2 bottom: 0).
	element
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	editor := BrTextEditor new
		text: text;
		yourself.
	element editor: editor.
	^ element
]

{ #category : #initialization }
GtRenamePreviewAttribute >> initialize [
	super initialize.
	self beNotOverwritableByStyler
]

{ #category : #testing }
GtRenamePreviewAttribute >> isEditorAttribute [
	^ false
]

{ #category : #accessing }
GtRenamePreviewAttribute >> text [
	^ text
]

{ #category : #accessing }
GtRenamePreviewAttribute >> text: blText [
	text := blText asString asRopedText.
	originalAttributes isNil
		ifTrue: [ originalAttributes := blText isEmpty
				ifTrue: [ #() ]
				ifFalse: [ blText attributesAt: 1 ] ].
	text
		attributes:
			originalAttributes
				,
					{(BlTextUnderlineAttribute new paint: BrGlamorousColors textHighlightColor)}
]

{ #category : #accessing }
GtRenamePreviewAttribute >> uninstallEventHandlers [
]

{ #category : #accessing }
GtRenamePreviewAttribute >> updateText: blText [
	self text: blText.
	element notNil
		ifTrue: [ element editor text: text ]
]
