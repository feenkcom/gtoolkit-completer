Class {
	#name : #GtRenameEditorAttribute,
	#superclass : #GtRenamePreviewAttribute,
	#instVars : [
		'cursorLocation',
		'selectAll',
		'filter',
		'editorShortcuts'
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
	element
		padding:
			(BlInsets
				top: 0
				left: 2
				bottom: 0
				right: 2).
	filter notNil
		ifTrue: [ element inputFilter: filter ].
	element switchToEditor.
	element editor text: text.
	element editor
		when: BrTextEditorModifiedEvent
		do: [ :event | renameAction updateName: element editor text ].
	element
		addEventFilterOn: BlFocusOutEvent
		do: [ :event | self updateFocus: event ].
	element editor moveCursorTo: (cursorLocation min: element editor text size).
	selectAll
		ifTrue: [ element editor selecter all select ].
	element editor addEditorShortcuts: self editorShortcuts.
	anEditorElement
		enqueueTask: (BlTaskAction new action: [ element requestFocus ]).
	^ BlElement new
		layout: BlLinearLayout horizontal;
		margin:
			(BlInsets
				top: 0
				left: -2
				bottom: 0
				right: -2);
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
GtRenameEditorAttribute >> editorShortcuts [
	^ editorShortcuts
		ifNil: [ editorShortcuts := {
			(BlShortcutWithAction new
				combination: BlKeyCombination escape;
				action: [ :aShortcutEvent | self renameAction cancel ]).
			(BlShortcutWithAction new
				combination: BlKeyCombination builder shift tab build;
				action: [ :aShortcutEvent | self renameAction tabAccept: false ]).
			(BlShortcutWithAction new
				combination: BlKeyCombination tab;
				action: [ :aShortcutEvent | self renameAction tabAccept: true ]).
			(BlShortcutWithAction new
				combination: BlKeyCombination return;
				action: [ :aShortcutEvent | self renameAction accept ])} ]
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
GtRenameEditorAttribute >> renameAction [
	^ renameAction
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
		ifTrue: [ element editor removeEditorShortcuts: self editorShortcuts ]
]

{ #category : #accessing }
GtRenameEditorAttribute >> updateFocus: event [
	renameAction isInstalled
		ifTrue: [ renameAction lostFocus ]
]
