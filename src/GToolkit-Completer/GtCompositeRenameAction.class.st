Class {
	#name : #GtCompositeRenameAction,
	#superclass : #GtRenameAction,
	#instVars : [
		'otherTextIntervals',
		'otherTextAttributes'
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
	self addLocations: intervals toText: anEditor text
]

{ #category : #private }
GtCompositeRenameAction >> addLocations: intervals toText: ropedText [
	otherTextIntervals
		at: ropedText
		put: (intervals asSortedCollection: [ :a :b | a first < b first ])
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
	otherTextIntervals
		keysAndValuesDo: [ :text :intervals | 
			otherTextAttributes
				at: text
				put:
					(intervals
						collect: [ :each | 
							| attribute |
							attribute := GtRenamePreviewAttribute new
								action: self;
								text: (text from: each first to: each last).
							(text from: each first to: each last) attributes: {attribute}.
							attribute ]) ]
]

{ #category : #'initialize-release' }
GtCompositeRenameAction >> initialize [
	super initialize.
	otherTextIntervals := IdentityDictionary new.
	otherTextAttributes := IdentityDictionary new
]

{ #category : #private }
GtCompositeRenameAction >> removeAttributes [
	super removeAttributes.
	self removeOtherAttributes
]

{ #category : #private }
GtCompositeRenameAction >> removeOtherAttributes [
	otherTextAttributes
		keysDo:
			[ :text | text clearAttributes: [ :each | self isRenameAttribute: each ] ]
]

{ #category : #private }
GtCompositeRenameAction >> undoChanges [
	super undoChanges.
	self removeOtherAttributes
]

{ #category : #actions }
GtCompositeRenameAction >> updateName: blText [
	super updateName: blText.
	otherTextAttributes
		do: [ :attrs | attrs do: [ :each | each updateText: blText ] ]
]

{ #category : #private }
GtCompositeRenameAction >> updateOtherEditors [
	self newName = self originalName
		ifTrue: [ ^ self ].
	otherTextIntervals
		keysAndValuesDo: [ :text :intervals | 
			self
				updateText: text
				at: intervals
				attributes: (otherTextAttributes at: text) ]
]

{ #category : #private }
GtCompositeRenameAction >> updateSource [
	super updateSource.
	self updateOtherEditors
]
