Class {
	#name : #GtCompositeRenameAction,
	#superclass : #GtRenameAction,
	#instVars : [
		'otherEditors',
		'newSize',
		'originalEditorsText'
	],
	#category : #'GToolkit-Completer-Actions'
}

{ #category : #coder }
GtCompositeRenameAction class >> coderRenameLocalsOnPattern: aTextEditorElement source: sourceEditor [
	| action |
	action := self pharoRenameLocalsOn: aTextEditorElement.
	action isNil
		ifTrue: [ ^ nil ].
	[ | tree positions variable |
	variable := action newName.
	positions := OrderedCollection new.
	tree := GtPharoParser parseWithErrors: sourceEditor text asString startingAt: GtPharoParser startingStateForMethodSequence.
	tree
		withAllNodesDo: [ :node | 
			((node isKindOf: GtPharoVariableNode) and: [ node name source = variable and: [ node isLocallyDefined not ] ])
				ifTrue: [ positions add: node startPosition ] ].
	positions sort.
	action addLocations: positions to: sourceEditor ]
		on: Error
		do: [ :ex | 
			action uninstall.
			^ nil ].
	^ action
]

{ #category : #coder }
GtCompositeRenameAction class >> coderRenameLocalsOnSource: aTextEditorElement pattern: patternEditor [
	^ [ | editor text ast items action patternAST parameter |
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
			definer := node whoDefines.
			definer isNil
				ifTrue: [ patternAST := GtPharoParser
						parseWithErrors: patternEditor text asString
						startingAt: GtPharoParser startingStateForMethodPattern.
					parameter := patternAST variables
						detect: [ :each | each = node ]
						ifNone: [ ^ nil ].
					definer := ast ].
			definer
				withAllNodesDo: [ :each | 
					each = node
						ifTrue: [ items add: (each startPosition to: each stopPosition) ] ]
				andTokensDo: nil
				includesErrors: true ].
	action := self locations: items element: aTextEditorElement.
	parameter notNil
		ifTrue: [ action addLocations: {parameter startPosition} to: patternEditor ].
	action install ]
		on: Error
		do: [ :ex | ex return: nil ]
]

{ #category : #private }
GtCompositeRenameAction >> addLocations: integerCollection to: anEditor [
	otherEditors at: anEditor put: integerCollection.
	originalEditorsText at: anEditor put: anEditor text copy.
	self addRenameAttributesToOtherEditors
]

{ #category : #private }
GtCompositeRenameAction >> addRenameAttributesToOtherEditors [
	self removeOtherAttributes.
	newSize < 1
		ifTrue: [ ^ self ].
	otherEditors
		keysAndValuesDo: [ :editor :positions | 
			positions do: [ :each | (editor text from: each to: each + newSize - 1) attributes: {GtRenameAttribute new} ].
			editor updater all update ]
]

{ #category : #installation }
GtCompositeRenameAction >> editorEventHandlers [
	^ super editorEventHandlers
		,
			{(BlEventHandler
				on: BrTextEditorDeletedEvent
				do: [ :event | self textDeleted: event ])}
]

{ #category : #'initialize-release' }
GtCompositeRenameAction >> initialize [
	super initialize.
	otherEditors := IdentityDictionary new.
	originalEditorsText := IdentityDictionary new
]

{ #category : #accessing }
GtCompositeRenameAction >> locations: aCollection [
	super locations: aCollection.
	newSize := originalLocations first size
]

{ #category : #'event handling' }
GtCompositeRenameAction >> newName [
	^ (self text copyFrom: originalLocations first first to: originalLocations first first + newSize - 1) asString
]

{ #category : #private }
GtCompositeRenameAction >> removeAttributes [
	super removeAttributes.
	self removeOtherAttributes
]

{ #category : #private }
GtCompositeRenameAction >> removeOtherAttributes [
	otherEditors
		keysDo: [ :editor | 
			editor text clearAttributes: [ :each | each isKindOf: GtRenameAttribute ].
			editor updater all update ]
]

{ #category : #private }
GtCompositeRenameAction >> replaceFrom: from to: to with: aString in: anEditor [
	| attributes |
	attributes := #().
	from <= to
		ifTrue: [ attributes := anEditor text attributesAt: from.
			anEditor deleter
				from: from - 1 to: to;
				delete ].
	aString notEmpty
		ifTrue: [ anEditor inserter
				at: from - 1;
				string: aString;
				insert.
			(anEditor text from: from to: from + aString size - 1) attributes: attributes ]
]

{ #category : #'event handling' }
GtCompositeRenameAction >> textDeleted: anEvent [
	| oldSize |
	anEvent fromIndex > (originalLocations first first + newSize)
		ifTrue: [ ^ self ].
	anEvent toIndex < originalLocations first first
		ifTrue: [ ^ self ].
	oldSize := newSize.
	newSize := newSize - anEvent toIndex + anEvent fromIndex - 1.
	self updateOtherLocationsWith: self newName previousSize: oldSize
]

{ #category : #'event handling' }
GtCompositeRenameAction >> textInserted: anEvent [
	| oldSize |
	super textInserted: anEvent.
	(anEvent index between: originalLocations first first - 1 and: originalLocations first first + newSize - 1)
		ifFalse: [ ^ self ].
	oldSize := newSize.
	newSize := newSize + anEvent text size.
	self updateOtherLocationsWith: self newName previousSize: oldSize
]

{ #category : #private }
GtCompositeRenameAction >> undoChanges [
	super undoChanges.
	originalEditorsText keysAndValuesDo: [ :editor :text | editor text: text ]
]

{ #category : #private }
GtCompositeRenameAction >> updateEditor: editor with: aString previousSize: oldSize [
	| sizeDifference positions newPositions offset |
	sizeDifference := newSize - oldSize.
	positions := otherEditors at: editor.
	offset := 0.
	newPositions := OrderedCollection new.
	positions
		do: [ :position | 
			| newPosition |
			newPosition := position + offset.
			self
				replaceFrom: newPosition
				to: newPosition + oldSize - 1
				with: aString
				in: editor.
			newPositions add: newPosition.
			offset := offset + sizeDifference ].
	otherEditors at: editor put: newPositions
]

{ #category : #private }
GtCompositeRenameAction >> updateOtherLocationsWith: aString previousSize: oldSize [
	otherEditors keys do: [ :editor | self updateEditor: editor with: aString previousSize: oldSize ].
	self addRenameAttributesToOtherEditors
]
