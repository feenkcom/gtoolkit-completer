Class {
	#name : #GtRenameEditorAttribute,
	#superclass : #GtRenamePreviewAttribute,
	#instVars : [
		'cursorLocation',
		'selectAll',
		'editorInteractions',
		'filter'
	],
	#category : #'GToolkit-Completer'
}

{ #category : #accessing }
GtRenameEditorAttribute >> additionalAttributes [
	^ #()
]

{ #category : #accessing }
GtRenameEditorAttribute >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	element := BrEditableLabel new.
	element
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	element
		look:
			(BrGlamorousEditableLabelLook new defaultBackground: Color transparent).
	filter notNil
		ifTrue: [ element inputFilter: filter ].
	element switchToEditor.
	element editor text: text.
	element editor
		when: BrTextEditorModifiedEvent
		do: [ :event | renameAction updateName: element editor text ].
	element
		addEventFilterOn: BlBaseFocusEvent
		do: [ :event | self updateFocus: event ].
	element editor moveCursorTo: cursorLocation.
	selectAll
		ifTrue: [ element editor selecter all select ].
	element editor addInteractions: self editorInteractions.
	anEditorElement
		enqueueTask: (BlTaskAction new action: [ element requestFocus ]).
	^ BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		addChild: element;
		yourself
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

{ #category : #accessing }
GtRenameEditorAttribute >> filter: aTextEditorInputFilter [
	filter := aTextEditorInputFilter.
	element notNil
		ifTrue: [ element inputFilter: aTextEditorInputFilter ]
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
	(event target hasFocus or: [ renameAction isInstalled not ])
		ifFalse: [ renameAction lostFocus ]
]
