"
1. # Class invariants


- action preview is visible then and only then when there is a selected action in the popup list

1. # Behaviour


- whenever selection in the popup list changes a preview is updated accordingly, therefore there is no need to manually control it

"
Class {
	#name : #GtCompletionController,
	#superclass : #Object,
	#instVars : [
		'completionDelay',
		'textElement',
		'attribute',
		'overlay',
		'listElement',
		'previewAction',
		'drillDownActions',
		'announcer',
		'lostFocusDelay',
		'closeOnEmptyCompletion',
		'textEditorHandlers',
		'textElementFilters',
		'popupHandlers',
		'textElementRemovedDelay',
		'showOnTextModification',
		'completer',
		'completionResult',
		'showPreviewAttributes'
	],
	#classVars : [
		'CompleteOnReturn',
		'PopupDelay'
	],
	#category : #'GToolkit-Completer-UI'
}

{ #category : #accessing }
GtCompletionController class >> completeOnReturn [
	"Return true if completion should complete when Enter is pressed, false otherwise"

	^ CompleteOnReturn
]

{ #category : #accessing }
GtCompletionController class >> completeOnReturn: aBoolean [
	CompleteOnReturn := aBoolean
]

{ #category : #'class initialization' }
GtCompletionController class >> initialize [
	PopupDelay := 200 milliSeconds.
	CompleteOnReturn := true
]

{ #category : #'instance creation' }
GtCompletionController class >> on: aTextElement [
	^ self new
		textElement: aTextElement;
		yourself
]

{ #category : #'instance creation' }
GtCompletionController class >> on: aTextElement strategy: aCompletionStrategy [
	^ self new
		textElement: aTextElement;
		strategy: aCompletionStrategy;
		yourself
]

{ #category : #accessing }
GtCompletionController class >> popupDelay [
	"Return popup delay as ==Duration=="
	<return: #Duration>

	^ PopupDelay
]

{ #category : #accessing }
GtCompletionController class >> popupDelay: aDuration [
	self
		assert: [ aDuration isNumber not ]
		description: [ 'Popup delay must not be a Number, it should be a Duration' ].

	PopupDelay := aDuration
]

{ #category : #'private - installation' }
GtCompletionController >> activeShortcutHandler [
	| activeShortcutHandler |
	activeShortcutHandler := GtCompletionShortcutHandler new.
	activeShortcutHandler
		completionController: self;
		whenActive;
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination arrowDown;
				action: [ self selectNextItem ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination arrowUp;
				action: [ self selectPreviousItem ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination builder primary arrowRight build;
				action: [ self drillDown ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination builder primary arrowLeft build;
				action: [ self undoDrillDown ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination tab;
				action: [ self completeWithCursor: true ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: self primaryLetterKeyCombinations;
				action: [ activeShortcutHandler consumeEvent: false.
					self removePopup ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination escape;
				action: [ self removePopup ]).

	self class completeOnReturn
		ifTrue: [ activeShortcutHandler addShortcut:
			(BlShortcutWithAction new
				repeatable: false;
				combination: BlKeyCombination enter;
				action: [ :event |
					event consumed: true.
					self completeWithCursor: true ]) ].

	^ activeShortcutHandler
]

{ #category : #'private - popup' }
GtCompletionController >> addAttachmentAttributeAt: anIndex [
	| position attributes |
	position := self completionResult popupPosition ifNil: [ anIndex ].

	position := (position min: self textEditor text size) - 1 max: 0.
	self textEditor text
		clearAttributes: 0
		to: self textEditor text size
		if: [ :each | each == attribute ].
	attributes := OrderedCollection with: attribute.
	self textEditor text
		clearAttributes: position
		to: position
		if: [ :each | 
			attributes add: each.
			true ].
	self textEditor text
		attributes: attributes
		from: position
		to: position
]

{ #category : #'private - accessing' }
GtCompletionController >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'private - preview' }
GtCompletionController >> applyPreview [

	self
		assert: [ previewAction isNil ]
		"otherwise preview text gets duplicated in the editor"
		description: [ 'Preview can only be applied when there is no active preview action' ].

	self
		ignoreTextEventsWhile: [
			self selectedCompletionItemDo: [ :aCompletionAction |
				previewAction := aCompletionAction.

				GtCompletionApplyPreviewSignal new
					action: previewAction;
					emit.

				showPreviewAttributes ifTrue: [ previewAction previewOn: self ] ] ]
]

{ #category : #'private - preview' }
GtCompletionController >> cancelPreview [
	previewAction
		ifNil: [ ^ self ].

	self
		ignoreTextEventsWhile: [
			GtCompletionCancelPreviewSignal new
					action: previewAction;
					emit.
			
			showPreviewAttributes ifTrue: [ previewAction undoPreviewOn: self ].
			previewAction := nil ]
]

{ #category : #'private - list selection' }
GtCompletionController >> clickedLabel: event [
	| clickedItem |
	
	"is sent when an item is clicked in the completion list, which means that the list must be already initialized"
	self
		assert: [ listElement notNil ]
		description: [ 'List element must be initialized here' ].
	
	clickedItem := event currentTarget userData at: #completion ifAbsent: [  ].
	clickedItem ifNil: [ ^ self ].
	listElement
		selectedItemDo:
			[ :each | 
			each == clickedItem
				ifTrue:
					[ event consumed: true.
					self completeFromClick ] ]
]

{ #category : #accessing }
GtCompletionController >> closeOnEmptyCompletion [
	^ closeOnEmptyCompletion
]

{ #category : #accessing }
GtCompletionController >> closeOnEmptyCompletion: aBoolean [
	closeOnEmptyCompletion := aBoolean
]

{ #category : #'private - list selection' }
GtCompletionController >> completeFromClick [
	self showPreview.
	self completeWithCursor: true.
	textElement requestFocus
]

{ #category : #popup }
GtCompletionController >> completeWithAction: aGtCompletionAction [
	previewAction := aGtCompletionAction.
	self completeWithCursor: true
]

{ #category : #private }
GtCompletionController >> completeWithCursor: aBoolean [
	self
		ignoreTextEventsWhile:
			[ | partial |
			partial := false.
			previewAction notNil
				ifTrue:
					[ partial := previewAction isPartial.
					previewAction finishCompletionOn: self moveCursor: aBoolean.
					self resetActions ].
			partial
				ifTrue:
					[ self
						updatePopupItemsAt: self position
						autoSelect: true
						andThen: [ self announcer announce: GtCompleterCompletionAccepted new ] ]
				ifFalse:
					[ self removePopup.
					self announcer announce: GtCompleterCompletionAccepted new ] ]
]

{ #category : #'private - accessing' }
GtCompletionController >> completionResult [
	^ completionResult ifNil: [ GtCompletionResult empty ]
]

{ #category : #'event handling' }
GtCompletionController >> cursorMoved: anEvent [
	anEvent newIndex = anEvent oldIndex
		ifTrue: [ ^ self ].
	(anEvent dueTo isDeleter or: [ anEvent dueTo isInserter ])
		ifFalse: [ self removePopup ]
]

{ #category : #'private - list selection' }
GtCompletionController >> deselectAll [
	"Deselect all completion actions"
	
	"completion list may not be initialized"
	listElement
		ifNotNil: [ :aListElement | aListElement deselectAll ]
]

{ #category : #private }
GtCompletionController >> drillDown [
	previewAction
		ifNil: [ ^ self ].
	
	self
		ignoreTextEventsWhile: [
			drillDownActions addLast: previewAction.
			previewAction drillDownOn: self.
			previewAction := nil.
			self updatePopupItemsAt: self position autoSelect: true ]
]

{ #category : #private }
GtCompletionController >> ignoreTextEventsWhile: aBlock [
	self uninstallTextEditorHandlers.
	aBlock
		ensure: [ self installTextEditorHandlers ]
]

{ #category : #'private - installation' }
GtCompletionController >> inactiveShortcutHandler [
	| inactiveShortcutHandler |
	inactiveShortcutHandler := GtCompletionShortcutHandler new.
	inactiveShortcutHandler
		completionController: self;
		whenInactive;
		addShortcut:
			(BlShortcutWithAction new
				repeatable: false;
				combination:
					(BlKeyCombination builder control
						key: BlKeyboardKey space;
						build);
				action: [ :event | 
					| shouldHandle |
					shouldHandle := event target == textElement.
					inactiveShortcutHandler consumeEvent: shouldHandle.
					shouldHandle
						ifTrue: [ self startCompletion ] ]);
		addShortcut:
			(BlShortcutWithAction new
				repeatable: false;
				combination: BlKeyCombination tab;
				action: [ :event | 
					inactiveShortcutHandler
						consumeEvent: (event target == textElement and: [ self processTabKey: true ]) ]);
		addShortcut:
			(BlShortcutWithAction new
				repeatable: false;
				combination: BlKeyCombination builder shift tab build;
				action: [ :event | 
					inactiveShortcutHandler
						consumeEvent: (event target == textElement and: [ self processTabKey: false ]) ]).
	^ inactiveShortcutHandler
]

{ #category : #'initialize-release' }
GtCompletionController >> initialize [
	super initialize.
	
	completer := GtCompleter new.

	drillDownActions := OrderedCollection new.
	closeOnEmptyCompletion := false.
	showPreviewAttributes := false.
	showOnTextModification := true.
	
	"list element is initialized lazily in #showListItems:"
	listElement := nil.
	overlay := self newPopupElement.

	completionDelay := BlDelayedTaskAction new.
	completionDelay delay: self class popupDelay.

	lostFocusDelay := BlDelayedTaskAction new.
	lostFocusDelay delay: 5 milliSeconds.

	textElementRemovedDelay := BlDelayedTaskAction new.
	textElementRemovedDelay delay: 50 milliSeconds.

	attribute := GtCompletionAttachmentAttribute for: self
]

{ #category : #installation }
GtCompletionController >> install [
	self installTextEditorHandlers.
	self installTextElementFilters.
	self installPopupHandlers
]

{ #category : #'private - installation' }
GtCompletionController >> installPopupHandlers [
	
	"we will try to install the popup handlers when we initialize the list lazily"
	listElement
		ifNil: [ ^ self ].
	self popupHandlers do: [ :each | listElement addEventHandler: each ]
]

{ #category : #'private - installation' }
GtCompletionController >> installTextEditorHandlers [
	self textEditorHandlers
		do: [ :each |
			(self textEditor hasEventHandler: each)
				ifFalse: [ self textEditor addEventHandler: each ] ]
]

{ #category : #'private - installation' }
GtCompletionController >> installTextElementFilters [
	self textElementFilters
		do: [ :each | textElement addEventFilter: each ]
]

{ #category : #testing }
GtCompletionController >> isActive [
	"Return true if completion is active. For example if a popup is shown to the user
	or if we are in argument completion mode (Tab/shift+tab navigation between arguments)"
	
	^ self isShowingPopup
]

{ #category : #testing }
GtCompletionController >> isAtStartOfLine [
	| text position char aCursor |
	text := self text.
	aCursor := self textEditor cursors first.
	position := aCursor position.
	[ position > 0 and: [ (char := text at: position) isSeparator ] ]
		whileTrue: [ (char = Character cr or: [ char = Character lf ])
				ifTrue: [ ^ true ].
			position := position - 1 ].
	^ position <= 0
]

{ #category : #testing }
GtCompletionController >> isShowingPopup [
	"Return true if the popup is currently visible to the user (attached to the scene graph)"
	<return: #Boolean>

	^ overlay isAttachedToSceneGraph
]

{ #category : #testing }
GtCompletionController >> isUncompletedAt: position [
	^ (self text attributesAt: position) anySatisfy: [ :each | each isKindOf: GtCompletionPartAttribute ]
]

{ #category : #private }
GtCompletionController >> moveCursorToNextUncompletedItem: direction [
	^ (self nextUncompletedItem: direction)
		ifNil: [ false ]
		ifNotNil: [ :position | 
			self textEditor moveCursorTo: position.
			true ]
]

{ #category : #'private - instance creation' }
GtCompletionController >> newCompletionList [
	<return: #BrSimpleList>
	
	^ (BrSimpleList new)
		id: #'completion-list';
		fitContentLimited;
		aptitudeDo: [ :aListLook | aListLook listElement constraints maxHeight: 200 ];
		items: #();
		itemStencil:
				[ (BrLabel new)
						when: BlClickEvent do: [ :evt | self clickedLabel: evt ];
						hMatchParent;
						constraintsDo: [ :c | c minWidth: 150 ];
						aptitude: BrGlamorousLabelAptitude + BrGlamorousListItemAptitude;
						padding:
								(BlInsets
										top: 1
										left: 10
										bottom: 1
										right: 10) ];
		itemDataBinder:
				[ :eachLabel :eachCompletion | 
					eachLabel userData at: #completion put: eachCompletion.
					eachLabel text: eachCompletion displayText ]
]

{ #category : #'private - instance creation' }
GtCompletionController >> newPopupElement [
	^ GtCompletionPopupElement new
		layout: BlLinearLayout vertical;
		aptitude: BrShadowAptitude new;
		background: Color white;
		constraintsDo: [ :c |
			c vertical fitContentLimited.
			c horizontal fitContentLimited ]
]

{ #category : #private }
GtCompletionController >> nextUncompletedItem: direction [
	| text position originalPosition aCursor |
	text := self text.
	aCursor := self textEditor cursors first.
	originalPosition := aCursor position.
	position := originalPosition.
	[ (position between: 1 and: text size)
		and: [ self isUncompletedAt: position ] ]
		whileTrue: [ position := position + direction ].
	[ position between: 1 and: text size ]
		whileTrue: [ (self isUncompletedAt: position)
				ifTrue: [ self selectUncompletedAt: position.
					^ position ].
			position := position + direction ].
	position := direction > 0
		ifTrue: [ 1 ]
		ifFalse: [ text size ].
	[ position ~= originalPosition ]
		whileTrue: [ (self isUncompletedAt: position)
				ifTrue: [ self selectUncompletedAt: position.
					^ position ].
			position := position + direction ].
	^ nil
]

{ #category : #'private - cursor' }
GtCompletionController >> onAttached: anElement [
	overlay attachTo: anElement.
	overlay visibility: BlVisibility visible.
	textElementRemovedDelay stop
]

{ #category : #'private - list selection' }
GtCompletionController >> onSelectionChanged: anEvent [
	anEvent sourceEvent
		ifNil:
			[ self scrollToSelected.
			self showPreview.
			textElement enqueueTask: (BlTaskAction new action: [ textElement requestFocus ]) ]
		ifNotNil: [ :aSourceEvent | aSourceEvent isMouse ifTrue: [ self completeFromClick ] ]
]

{ #category : #popup }
GtCompletionController >> popupElement: anElement [
	(overlay children size = 1 and: [ overlay children first == anElement ]) ifTrue: [ ^ self ].
	overlay removeChildren.
	overlay addChild: anElement
]

{ #category : #'private - installation' }
GtCompletionController >> popupHandlers [
	^ popupHandlers
		ifNil: [ popupHandlers := {(BlEventHandler
				on: BrSelectionChanged
				do: [ :event | self onSelectionChanged: event ]).
			(BlEventHandler
				on: BlBlurEvent
				do: [ :event | self removePopupOnLostFocus ])} ]
]

{ #category : #private }
GtCompletionController >> position [
	^ self textEditor cursors first position
]

{ #category : #private }
GtCompletionController >> primaryLetterKeyCombinations [
	| combination |
	
	combination := BlKeyCombination primaryA.
	$b asInteger to: $z asInteger do: [ :i |
		| primaryKeyCombination |
		primaryKeyCombination := BlKeyCombination builder
			primary;
			key: (BlKeyboardKey perform: (Character value: i) asSymbol);
			build.
		combination := combination or: primaryKeyCombination ].
	
	^ combination
]

{ #category : #'event handling' }
GtCompletionController >> processReturnKey: anEvent [
	self completeWithCursor: true.
	anEvent consumed: true
]

{ #category : #'event handling' }
GtCompletionController >> processTabKey: forwardBoolean [
	| direction |
	self isShowingPopup
		ifTrue: [ ^ false ].
	self isAtStartOfLine
		ifFalse: [ direction := forwardBoolean
				ifTrue: [ 1 ]
				ifFalse: [ -1 ].
			(self moveCursorToNextUncompletedItem: direction)
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'private - popup' }
GtCompletionController >> removeAttachmentAttribute [
	self textEditor text clearAttributes: [ :each | each == attribute ]
]

{ #category : #'private - popup' }
GtCompletionController >> removePopup [
	self cancelPreview.
	self resetPopup.
	completer showRequested: false.
	overlay detach.
	overlay removeFromParent.
	self removeAttachmentAttribute
]

{ #category : #popup }
GtCompletionController >> removePopupElement [
	overlay removeChildren
]

{ #category : #'private - popup' }
GtCompletionController >> removePopupOnAnchorRemoved [
	textElementRemovedDelay action: [ self removePopup ].
	textElementRemovedDelay element: overlay.
	textElementRemovedDelay startOrRestart
]

{ #category : #'private - popup' }
GtCompletionController >> removePopupOnLostFocus [
	lostFocusDelay
		action: [ (textElement hasFocus or: [ listElement ifNil: [ false ] ifNotNil: [ :aListElement | aListElement hasFocus ] ])
				ifFalse: [ self removePopup ] ].
	lostFocusDelay startOrRestart
]

{ #category : #private }
GtCompletionController >> removeUncompletedAttributeAt: anInteger [
	| text position |
	text := self text.
	position := anInteger.
	[ position <= text size and: [ self isUncompletedAt: position ] ] whileTrue: [ position := position + 1 ].
	text
		clearAttributes: anInteger
		to: position - 1
		if: [ :each | each isKindOf: GtCompletionPartAttribute ]
]

{ #category : #private }
GtCompletionController >> resetActions [
	previewAction := nil.
	drillDownActions := OrderedCollection new
]

{ #category : #'private - popup' }
GtCompletionController >> resetPopup [
	listElement ifNotNil: [ :aListElement | aListElement items: #() ].
	self cancelPreview.
	completionDelay stop
]

{ #category : #'private - list selection' }
GtCompletionController >> scrollTo: anIndex [
	self flag: 'Implement corresponding list api'.
	
	self
		assert: [ listElement notNil ]
		description: [ 'List element must be initialized here' ].
	listElement children first scrollToPosition: anIndex
]

{ #category : #'private - list selection' }
GtCompletionController >> scrollToSelected [
	self selectedCompletionIndexDo: [ :anIndex | self scrollTo: anIndex ]
]

{ #category : #'private - list selection' }
GtCompletionController >> selectAction: aCompletionAction [
	"Select the given completion action deselecting the other ones"

	self completionResult  completionActionsWithIndexDo: [ :action :i | action = aCompletionAction ifTrue: [ ^ self selectAt: i ] ].
	self deselectAll
]

{ #category : #'private - list selection' }
GtCompletionController >> selectAt: anIndex [
	"Select a completion action at a given index deselecting all other ones"

	self
		assert: [ listElement notNil ]
		description: [ 'List element must be initialized here' ].
	listElement selectOne: anIndex
]

{ #category : #'private - list selection' }
GtCompletionController >> selectFirst [
	"Select the first completion action deselecting the other ones"

	self selectAt: 1
]

{ #category : #'private - list selection' }
GtCompletionController >> selectNextItem [
	self
		assert: [ listElement notNil ]
		description: [ 'List element must be initialized here' ].
	listElement selectNext
]

{ #category : #'private - list selection' }
GtCompletionController >> selectPreviousItem [
	self
		assert: [ listElement notNil ]
		description: [ 'List element must be initialized here' ].
	listElement selectPrevious
]

{ #category : #private }
GtCompletionController >> selectUncompletedAt: position [
	| first |
	first := position - 1.
	[ first >= 1 and: [ self isUncompletedAt: first ] ]
		whileTrue: [ first := first - 1 ].
	self textEditor selecter
		overwrite;
		from: first to: first + 1;
		withoutCursorUpdate;
		select
]

{ #category : #'private - list selection' }
GtCompletionController >> selectedCompletionIndexDo: aBlock [
	"Evaluate a given block with the current selection index if there is one"
	
	self
		assert: [ listElement notNil ]
		description: [ 'List element must be already initialized' ].
	
	listElement selectedIndices
		ifNotEmpty: [ :theIndices | aBlock value: theIndices first ]
]

{ #category : #'private - list selection' }
GtCompletionController >> selectedCompletionItemDo: aBlock [
	"Evaluate a given block with the currently selected completion item if there is one"

	self
		selectedCompletionIndexDo:
			[ :anIndex | self completionResult completionActionsWithIndexDo: [ :action :i | i = anIndex ifTrue: [ ^ aBlock value: action ] ] ]
]

{ #category : #popup }
GtCompletionController >> showListItems: aStream [
	"Initialize a completion list element with a given stream of completion candidates.
	#listElement is initialized lazily in this method"
	| theActionsToDisplay |
	
	listElement ifNil: [
		listElement := self newCompletionList.
		overlay addChild: listElement.
		self installPopupHandlers ].

	self popupElement: listElement.

	"action is deselected => preview is cancelled"
	self deselectAll.
	theActionsToDisplay := aStream.
	(self closeOnEmptyCompletion and: [ completer showRequested not ])
		ifTrue:
			[ ((theActionsToDisplay asyncSimilarCopy take: 3) toArray wait anySatisfy: [ :each | each isEmpty ])
				ifTrue: [ theActionsToDisplay := #() asAsyncStream ] ].
	listElement
		itemsProvider:
			(BrStreamItemsProvider new
				preloadAmount: 10;
				stream: theActionsToDisplay).
	self completionResult hasCompletionActions ifTrue: [ self selectFirst ] ifFalse: [ self removePopup ]
]

{ #category : #accessing }
GtCompletionController >> showOnTextModification [
	^ showOnTextModification
]

{ #category : #accessing }
GtCompletionController >> showOnTextModification: aBoolean [
	showOnTextModification := aBoolean
]

{ #category : #'private - popup' }
GtCompletionController >> showPopupAt: anIndex [

	"Show the completion popup selecting the first relevant completion item"
	textElement editor assertUIProcess.
	
	"if the show popup appears when editor is not in the scene graph,
	just ignore the request"
	textElement isAttachedToSceneGraph ifFalse: [ ^ self ].

	self updatePopupItemsAt: anIndex autoSelect: true andThen: [
		(self isShowingPopup or: [ self completionResult hasCompletionActions not ])
			ifTrue: [ completer showRequested: false ]
			ifFalse: [ 
				self
					assert: [ overlay isAttachedToSceneGraph not ]
					description: [ 'Overlay must not be already visible' ].
				
				"it is theoretically possible that the text element disappears from the scene graph
				while the completion is computed. in that case we shouldn't add an overlay"
				textElement isAttachedToSceneGraph
					ifTrue: [
						self addAttachmentAttributeAt: anIndex.

						textElement space root addChild: overlay ] ] ]
]

{ #category : #'private - preview' }
GtCompletionController >> showPreview [
	"Show completion preview for a currently selected action or remove
	the existing preview if none is selected"

	self cancelPreview.
	self applyPreview
]

{ #category : #accessing }
GtCompletionController >> showPreviewAttributes [

	^ showPreviewAttributes
]

{ #category : #accessing }
GtCompletionController >> showPreviewAttributes: aBoolean [

	showPreviewAttributes := aBoolean
]

{ #category : #'event handling' }
GtCompletionController >> startCompletion [
	| location |
	self textEditor cursors cursorsCount = 1
		ifFalse: [ ^ self ].
	completer showRequested: true.
	location := self textEditor cursors first position.
	self showPopupAt: location
]

{ #category : #'private - popup' }
GtCompletionController >> startCompletionAt: aTextIndex [
	| aText |
	self resetPopup.
	
	"If we have multiple cursors, don't open the completion."
	self textEditor cursors cursorsCount = 1
		ifFalse: [
			self removePopup.
			^ self ].
			
	aText := self textEditor textSnapshot.			
			
	"If there are no completions for a given index, remove the popup"
	((completer strategyAt: aTextIndex in: aText)
		hasCompletionsAt: aTextIndex
		in: self text)
		ifFalse: [ ^ self removePopup ].
	self isShowingPopup
		ifTrue: [ self updatePopupItemsAt: aTextIndex autoSelect: true ]
		ifFalse: [ self startPopupDelayAt: aTextIndex ].
]

{ #category : #'private - popup' }
GtCompletionController >> startPopupDelayAt: anIndex [
	"Completion delay must already have element: attached,
	see ${method:GtCompletionController>>#textElement:}$"

	completionDelay action: [ self showPopupAt: anIndex ].
	completionDelay startOrRestart
]

{ #category : #'initialize-release' }
GtCompletionController >> strategy: aCompletionStrategy [
	completer defaultStrategy: aCompletionStrategy
]

{ #category : #'private - accessing' }
GtCompletionController >> text [
	<return: #BlText>

	^ self textEditor text
]

{ #category : #'event handling' }
GtCompletionController >> textDeleted: anEvent [
	self resetPopup.
	self isShowingPopup
		ifTrue: [ self startCompletionAt: anEvent fromIndex - 1 ]
]

{ #category : #'private - accessing' }
GtCompletionController >> textEditor [
	<return: #BrTextEditorModel>

	^ textElement editor
]

{ #category : #'private - installation' }
GtCompletionController >> textEditorHandlers [
	^ textEditorHandlers
		ifNil: [ textEditorHandlers := {(BlEventHandler
				on: BrTextEditorInsertedEvent
				do: [ :event | self textInserted: event ]).
			(BlEventHandler
				on: BrTextEditorDeletedEvent
				do: [ :event | self textDeleted: event ]).
			(BlEventHandler
				on: BrTextEditorCursorMovedEvent
				do: [ :event | self cursorMoved: event ])} ]
]

{ #category : #'initialize-release' }
GtCompletionController >> textElement: anEditorElement [
	textElement := anEditorElement.

	completionDelay element: textElement.
	lostFocusDelay element: textElement.
	textElementRemovedDelay element: textElement.
]

{ #category : #'private - installation' }
GtCompletionController >> textElementFilters [
	^ textElementFilters
		ifNil: [ textElementFilters := {self activeShortcutHandler.
					self inactiveShortcutHandler.
					BlEventHandler on: BlBlurEvent do: [ :event | self removePopupOnLostFocus ].
					BlEventHandler on: BlClickEvent do: [ :event | self removePopup ]} ]
]

{ #category : #'event handling' }
GtCompletionController >> textInserted: anEvent [
	(self showOnTextModification or: [ self isShowingPopup ])
		ifFalse: [ ^ self ].

	self startCompletionAt: anEvent index + anEvent text size
]

{ #category : #private }
GtCompletionController >> undoDrillDown [
	drillDownActions
		ifEmpty: [ ^ self ].
	self
		ignoreTextEventsWhile: [ | action |
			previewAction notNil
				ifTrue: [ self cancelPreview ].
			action := drillDownActions removeLast.
			action undoDrillDownOn: self.
			previewAction := action.
			self deselectAll.
			self updatePopupItemsAt: self position autoSelect: false.
			self selectAction: action.
			self showPreview ]
]

{ #category : #installation }
GtCompletionController >> uninstall [
	self cancelPreview.
	self uninstallPopupHandlers.
	self uninstallTextElementFilters.
	self uninstallTextEditorHandlers
]

{ #category : #'private - installation' }
GtCompletionController >> uninstallPopupHandlers [
	listElement
		ifNil: [ ^ self ].
	self popupHandlers
		do: [ :each | listElement removeEventHandler: each ]
]

{ #category : #'private - installation' }
GtCompletionController >> uninstallTextEditorHandlers [
	self textEditorHandlers
		do: [ :each | self textEditor removeEventHandler: each ]
]

{ #category : #'private - installation' }
GtCompletionController >> uninstallTextElementFilters [
	self textElementFilters
		do: [ :each | textElement removeEventFilter: each ]
]

{ #category : #'private - popup' }
GtCompletionController >> updatePopupItemsAt: anIndex autoSelect: shouldSelectFirst [
	self
		updatePopupItemsAt: anIndex
		autoSelect: shouldSelectFirst
		andThen: [ ]
]

{ #category : #'private - popup' }
GtCompletionController >> updatePopupItemsAt: anIndex autoSelect: shouldSelectFirst andThen: aBlock [
	| aText |
	aText := textElement editor textSnapshot.
	textElement enqueueTask: (BlPromiseTask new promise: (completer
		completeAsyncDo:
			[ :result | 
			completionResult := result.
			textElement
				enqueueTask:
					(BlTaskAction new
						action:
							[ result showOn: self.
							aBlock cull: result ]) ]
		in: aText
		at: anIndex))
]
