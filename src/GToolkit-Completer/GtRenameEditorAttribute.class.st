Class {
	#name : #GtRenameEditorAttribute,
	#superclass : #GtRenamePreviewAttribute,
	#instVars : [
		'cursorLocation',
		'selectAll',
		'editorInteractions'
	],
	#category : #'GToolkit-Completer'
}

{ #category : #accessing }
GtRenameEditorAttribute >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	| elmt |
	elmt := super affect: aTBrTextEditorTextualPiece in: anEditorElement.	
	elmt editor
		when: BrTextEditorModifiedEvent
		do: [ :event | renameAction updateName: elmt editor text ].
	elmt
		addEventFilterOn: BlBaseFocusEvent
		do: [ :event | self updateFocus: event ].
	elmt editor moveCursorTo: cursorLocation.
	selectAll
		ifTrue: [ elmt editor selecter all select ].

	elmt editor addInteractions: self editorInteractions.

	anEditorElement
		enqueueTask: (BlTaskAction new action: [ elmt requestFocus ]).
	^ elmt
]

{ #category : #accessing }
GtRenameEditorAttribute >> cursorLocation: anInteger [
	cursorLocation := anInteger
]

{ #category : #accessing }
GtRenameEditorAttribute >> editorCursorLocation [
	element notNil
		ifTrue: [ element editor cursors do: [ :cursor | ^ cursor position ] ].
	^ text size
]

{ #category : #private }
GtRenameEditorAttribute >> editorInteractions [
	^ editorInteractions
		ifNil: [ editorInteractions := {
			(BrTextEditorInteraction new
				combination: BlKeyCombination escape;
				action: [ renameAction cancel ]).
			(BrTextEditorInteraction new
				combination: BlKeyCombination tab;
				action: [ renameAction tabAccept ]).
			(BrTextEditorInteraction new
				combination: BlKeyCombination return;
				action: [ renameAction returnAccept ])} ]
]

{ #category : #initialization }
GtRenameEditorAttribute >> initialize [
	super initialize.
	selectAll := false
]

{ #category : #testing }
GtRenameEditorAttribute >> isEditorAttribute [
	^ true
]

{ #category : #accessing }
GtRenameEditorAttribute >> selectAll [
	^ selectAll
]

{ #category : #accessing }
GtRenameEditorAttribute >> selectAll: aBoolean [
	selectAll := aBoolean
]

{ #category : #accessing }
GtRenameEditorAttribute >> uninstallEventHandlers [
	element notNil
		ifTrue: [ element editor removeInteractions: self editorInteractions ]
]

{ #category : #accessing }
GtRenameEditorAttribute >> updateFocus: event [
	(event target focused or: [ renameAction isInstalled not ])
		ifFalse: [ renameAction lostFocus ]
]
