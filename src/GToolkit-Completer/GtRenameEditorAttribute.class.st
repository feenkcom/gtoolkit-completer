Class {
	#name : #GtRenameEditorAttribute,
	#superclass : #GtRenamePreviewAttribute,
	#instVars : [
		'cursorLocation',
		'selectAll',
		'eventHandlers'
	],
	#category : #'GToolkit-Completer'
}

{ #category : #accessing }
GtRenameEditorAttribute >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	| elmt |
	elmt := super affect: aTBrTextEditorTextualPiece in: anEditorElement.
	elmt editor
		when: BrTextEditorInsertedEvent
			do: [ :event | renameAction updateName: elmt editor text ];
		when: BrTextEditorDeletedEvent
			do: [ :event | renameAction updateName: elmt editor text ].
	elmt
		addEventFilterOn: BlBaseFocusEvent
		do: [ :event | self updateFocus: event ].
	elmt editor moveCursorTo: cursorLocation.
	selectAll
		ifTrue: [ elmt editor selecter all select ].
	self elementEventHandlers do: [ :each | elmt addEventFilter: each ].
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
GtRenameEditorAttribute >> elementEventHandlers [
	^ eventHandlers
		ifNil: [ eventHandlers := {(BlShortcutHandler new
				addShortcut:
					(BlShortcut new
						combination: BlKeyCombination escape;
						repeatable: false;
						action: [ renameAction cancel ]);
				addShortcut:
					(BlShortcut new
						combination: BlKeyCombination tab;
						repeatable: false;
						action: [ renameAction tabAccept ]);
				addShortcut:
					(BlShortcut new
						combination: BlKeyCombination return;
						repeatable: false;
						action: [ renameAction returnAccept ]))} ]
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
		ifTrue: [ self elementEventHandlers
				do: [ :each | element removeEventFilter: each ] ]
]

{ #category : #accessing }
GtRenameEditorAttribute >> updateFocus: event [
	(event target focused or: [ renameAction isInstalled not ])
		ifFalse: [ renameAction lostFocus ]
]
