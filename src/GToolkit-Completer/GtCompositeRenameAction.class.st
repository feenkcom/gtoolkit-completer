Class {
	#name : #GtCompositeRenameAction,
	#superclass : #GtRenameAction,
	#instVars : [
		'otherEditors',
		'originalEditorsText',
		'otherAttributes'
	],
	#category : #'GToolkit-Completer-Actions'
}

{ #category : #coder }
GtCompositeRenameAction class >> coderRenameLocalsOnPattern: aTextEditorElement source: sourceEditor [
	| action |
	action := self pharoRenameLocalsOn: aTextEditorElement.
	action isNil
		ifTrue: [ ^ nil ].
	[ | tree intervals variable |
	variable := action newName.
	intervals := OrderedCollection new.
	tree := GtPharoParser
		parseWithErrors: sourceEditor text asString
		startingAt: GtPharoParser startingStateForMethodSequence.
	tree
		withAllNodesDo: [ :node | 
			((node isKindOf: GtPharoVariableNode)
				and: [ node name source = variable and: [ node isLocallyDefined not ] ])
				ifTrue: [ intervals add: node sourceInterval ] ].
	action addLocations: intervals to: sourceEditor ]
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
		ifTrue: [ action addLocations: {parameter sourceInterval} to: patternEditor ].
	action install ]
		on: Error
		do: [ :ex | ex return: nil ]
]

{ #category : #private }
GtCompositeRenameAction >> addLocations: intervals to: anEditor [
	otherEditors
		at: anEditor
		put: (intervals asSortedCollection: [ :a :b | a first < b first ]).
	originalEditorsText at: anEditor put: anEditor text copy
]

{ #category : #private }
GtCompositeRenameAction >> addRenameAttributes [
	super addRenameAttributes.
	self addRenameAttributesToOtherEditors
]

{ #category : #private }
GtCompositeRenameAction >> addRenameAttributesToOtherEditors [
	| size |
	size := self originalName size.
	size < 1
		ifTrue: [ ^ self ].
	self removeOtherAttributes.
	otherEditors
		keysAndValuesDo: [ :editor :intervals | 
			otherAttributes
				at: editor
				put:
					(intervals
						collect: [ :each | 
							| attribute |
							attribute := GtRenamePreviewAttribute new
								action: self;
								text: (editor text from: each first to: each last).
							(editor text from: each first to: each last)
								attributes: {attribute}.
							attribute ]).
			editor updater all update ]
]

{ #category : #'initialize-release' }
GtCompositeRenameAction >> initialize [
	super initialize.
	otherEditors := IdentityDictionary new.
	originalEditorsText := IdentityDictionary new.
	otherAttributes := IdentityDictionary new
]

{ #category : #private }
GtCompositeRenameAction >> removeAttributes [
	super removeAttributes.
	self removeOtherAttributes
]

{ #category : #private }
GtCompositeRenameAction >> removeOtherAttributes [
	otherAttributes
		keysDo: [ :editor | 
			editor text clearAttributes: [ :each | self isRenameAttribute: each ].
			editor updater all update ]
]

{ #category : #private }
GtCompositeRenameAction >> undoChanges [
	super undoChanges.
	self removeOtherAttributes
]

{ #category : #actions }
GtCompositeRenameAction >> updateName: blText [
	super updateName: blText.
	otherAttributes
		do: [ :attrs | attrs do: [ :each | each updateText: blText ] ]
]

{ #category : #private }
GtCompositeRenameAction >> updateOtherEditors [
	self newName = self originalName
		ifTrue: [ ^ self ].
	otherEditors
		keysAndValuesDo: [ :editor :intervals | 
			self
				updateSourceIn: editor
				at: intervals
				attributes: (otherAttributes at: editor) ]
]

{ #category : #private }
GtCompositeRenameAction >> updateSource [
	super updateSource.
	self updateOtherEditors
]
