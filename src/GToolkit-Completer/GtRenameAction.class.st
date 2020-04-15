Class {
	#name : #GtRenameAction,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'textElement',
		'originalLocations',
		'originalText',
		'originalCursorPosition',
		'isInstalled',
		'renameAttributes',
		'selectAll'
	],
	#category : #'GToolkit-Completer-Actions'
}

{ #category : #'instance creation' }
GtRenameAction class >> locations: aCollectionOfIntervals element: aTextEditorElement [
	^ self new
		textElement: aTextEditorElement;
		locations: aCollectionOfIntervals;
		yourself
]

{ #category : #pharo }
GtRenameAction class >> pharoRenameLocalsOn: aTextEditorElement [
	^ [ | editor text ast items action |
	editor := aTextEditorElement editor.
	editor cursor cursorsCount = 1
		ifFalse: [ ^ nil ].
	text := editor text.
	ast := GtPharoParser parseWithErrors: text asString.
	items := OrderedCollection new.
	(ast findVariableNodeAt: editor cursor first position)
		ifNotNil: [ :node | 
			node whoDefines
				ifNotNil: [ :definer | 
					definer
						withAllNodesDo: [ :each | 
							each = node
								ifTrue: [ items add: (each startPosition to: each stopPosition) ] ]
						andTokensDo: nil
						includesErrors: true ] ].
	action := self locations: items element: aTextEditorElement.
	action install ]
		on: Error
		do: [ :ex | ex return: nil ]
]

{ #category : #pharo }
GtRenameAction class >> pharoRenameSnippetLocalsOn: aTextEditorElement [
	^ [ | editor text ast items action |
	editor := aTextEditorElement editor.
	editor cursor cursorsCount = 1
		ifFalse: [ ^ nil ].
	text := editor text.
	ast := GtPharoParser
		parseWithErrors: text asString
		startingAt: GtPharoParser startingStateForMethodSequence.
	items := OrderedCollection new.
	(ast findVariableNodeAt: editor cursor first position)
		ifNotNil: [ :node | 
			| definer |
			definer := node whoDefines ifNil: [ ast ].
			definer
				withAllNodesDo: [ :each | 
					each = node
						ifTrue: [ items add: (each startPosition to: each stopPosition) ] ]
				andTokensDo: nil
				includesErrors: true ].
	action := self locations: items element: aTextEditorElement.
	action install ]
		on: Error
		do: [ :ex | ex return: nil ]
]

{ #category : #actions }
GtRenameAction >> accept [
	self updateSource.
	self uninstall.
	self announceEvent: #accept
]

{ #category : #private }
GtRenameAction >> addRenameAttributes [
	| text cursorInLocation |
	text := self text.
	cursorInLocation := originalLocations
		anySatisfy:
			[ :each | originalCursorPosition between: each first - 1 and: each last ].
	renameAttributes := originalLocations
		collect: [ :each | 
			| attribute |
			attribute := (cursorInLocation not
				or:
					[ originalCursorPosition between: each first - 1 and: each last ])
				ifTrue: [ GtRenameEditorAttribute new
						action: self;
						selectAll: selectAll;
						cursorLocation: originalCursorPosition - each first + 1;
						text: (text from: each first to: each last) ]
				ifFalse: [ GtRenamePreviewAttribute new
						action: self;
						text: (text from: each first to: each last) ].
			cursorInLocation := true.
			(text from: each first to: each last) attributes: {attribute}.
			attribute ]
]

{ #category : #private }
GtRenameAction >> announceEvent: aSymbol [
	^ self announce: (GtRenameActionAnnoucement for: self type: aSymbol)
]

{ #category : #announcer }
GtRenameAction >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #actions }
GtRenameAction >> cancel [
	self uninstall.
	self undoChanges.
	self announceEvent: #cancel
]

{ #category : #'initialize-release' }
GtRenameAction >> initialize [
	super initialize.
	originalLocations := #().
	isInstalled := false.
	selectAll := false
]

{ #category : #installation }
GtRenameAction >> install [
	originalLocations isEmpty
		ifTrue: [ ^ self ].
	self saveOriginalState.
	self addRenameAttributes.
	isInstalled := true.
	self announceEvent: #install
]

{ #category : #testing }
GtRenameAction >> isInstalled [
	^ isInstalled
]

{ #category : #testing }
GtRenameAction >> isRenameAttribute: anAttribute [
	^ anAttribute isKindOf: GtRenamePreviewAttribute
]

{ #category : #accessing }
GtRenameAction >> locations: aCollectionOfIntervals [
	originalLocations := aCollectionOfIntervals asSortedCollection: [ :a :b | a first < b first ].
	self validateLocations
]

{ #category : #actions }
GtRenameAction >> lostFocus [
	self accept
]

{ #category : #private }
GtRenameAction >> newName [
	^ renameAttributes first text asString
]

{ #category : #private }
GtRenameAction >> originalName [
	^ (originalText
		copyFrom: originalLocations first first
		to: originalLocations first last) asString
]

{ #category : #private }
GtRenameAction >> removeAttributeHandlers [
	renameAttributes do: [ :each | each uninstallEventHandlers ]
]

{ #category : #private }
GtRenameAction >> removeAttributes [
	self text clearAttributes: [ :each | self isRenameAttribute: each ].
	self textEditor updater all update.
	self removeAttributeHandlers
]

{ #category : #actions }
GtRenameAction >> returnAccept [
	self accept
]

{ #category : #private }
GtRenameAction >> saveOriginalState [
	| text |
	text := self text.
	originalText := text copy.
	originalCursorPosition := self textEditor cursor first position
]

{ #category : #accessing }
GtRenameAction >> selectAll [
	^ selectAll
]

{ #category : #accessing }
GtRenameAction >> selectAll: anObject [
	selectAll := anObject
]

{ #category : #actions }
GtRenameAction >> tabAccept [
	self accept
]

{ #category : #accessing }
GtRenameAction >> text [
	^ self textEditor text
]

{ #category : #accessing }
GtRenameAction >> textEditor [
	^ self textElement editor
]

{ #category : #accessing }
GtRenameAction >> textElement [
	^ textElement
]

{ #category : #accessing }
GtRenameAction >> textElement: aTextEditorElement [
	textElement := aTextEditorElement
]

{ #category : #private }
GtRenameAction >> undoChanges [
	self textEditor text: originalText.
	self textEditor moveCursorTo: originalCursorPosition
]

{ #category : #installation }
GtRenameAction >> uninstall [
	self removeAttributes.
	isInstalled := false.
	self announceEvent: #uninstall.
	textElement
		enqueueTask: (BlTaskAction new action: [ textElement requestFocus ])
]

{ #category : #private }
GtRenameAction >> updateCursorLocation [
	| sizeDifference offset |
	sizeDifference := self newName size - self originalName size.
	offset := 0.
	originalLocations
		with: renameAttributes
		do: [ :interval :attr | 
			attr isEditorAttribute
				ifTrue: [ textElement editor
						moveCursorTo:
							(interval first + offset + attr editorCursorLocation - 1
								min: textElement editor text size).
					^ self ].
			offset := offset + sizeDifference ]
]

{ #category : #actions }
GtRenameAction >> updateName: blText [
	renameAttributes do: [ :each | each updateText: blText ]
]

{ #category : #private }
GtRenameAction >> updateSource [
	self newName = self originalName
		ifTrue: [ ^ self removeAttributes ].
	self
		updateSourceIn: self textEditor
		at: originalLocations
		attributes: renameAttributes.
	self updateCursorLocation
]

{ #category : #private }
GtRenameAction >> updateSourceIn: editor at: intervals attributes: attributeCollection [
	| newText index |
	newText := '' asRopedText.
	index := 1.
	intervals
		with: attributeCollection
		do: [ :each :attr | 
			each first = 1
				ifTrue: [ newText := newText , attr text ]
				ifFalse: [ newText := newText
						, (editor text copyFrom: index to: each first - 1) , attr text ].
			index := each last + 1 ].
	index > editor text size
		ifFalse: [ newText := newText
				, (editor text copyFrom: index to: editor text size) ].
	editor text: newText
]

{ #category : #private }
GtRenameAction >> validateLocations [
	| lastLocation size |
	originalLocations isEmpty
		ifTrue: [ ^ self ].
	lastLocation := 0.
	size := originalLocations first size.
	originalLocations
		do: [ :each | 
			each first <= lastLocation
				ifTrue: [ self error: 'Cannot rename overlapping locations' ].
			lastLocation := each last.
			each size ~= size
				ifTrue: [ self error: 'Cannot rename items of different sizes' ] ]
]
