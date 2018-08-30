"
!! Class invariants

- action preview is visible then and only then when there is a selected action in the popup list

!! Behaviour

- whenever selection in the popup list changes a preview is updated accordingly, therefore there is no need to manually control it
"
Class {
	#name : #GtCompletionController,
	#superclass : #Object,
	#instVars : [
		'strategy',
		'completionDelay',
		'textElement',
		'overlay',
		'listElement',
		'eventFilters',
		'eventHandlers',
		'popupEventFilters',
		'popupEventHandlers',
		'lastWasText',
		'previewAction',
		'drillDownActions',
		'cursorElement',
		'ignoreTextEvents'
	],
	#classVars : [
		'MaxPopupItems',
		'PopupDelay'
	],
	#category : 'GToolkit-Completer-UI'
}

{ #category : #'class initialization' }
GtCompletionController class >> initialize [
	PopupDelay := 200 milliSeconds.
	MaxPopupItems := 100
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

				previewAction previewOn: self ] ].
	lastWasText := false
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
			
			previewAction undoPreviewOn: self.
			previewAction := nil ]
]

{ #category : #private }
GtCompletionController >> completeWithCursor: aBoolean [
	self
		ignoreTextEventsWhile: [ | partial |
			partial := false.
			previewAction notNil
				ifTrue: [ partial := previewAction isPartial.
					previewAction finishCompletionOn: self moveCursor: aBoolean.
					self resetActions ].
			self deselectAll.
			partial
				ifTrue: [ self updatePopupItemsAt: self position autoSelect: true ]
				ifFalse: [ self removePopup ] ]
]

{ #category : #'private - accessing' }
GtCompletionController >> completionActions [
	<return: #Collection of: #GtCompletionAction>

	^ listElement items
]

{ #category : #'private - accessing' }
GtCompletionController >> completionActions: aCollectionOfGtCompletionAction [
	listElement items: aCollectionOfGtCompletionAction
]

{ #category : #'event handling' }
GtCompletionController >> cursorMoved: anEvent [
	(anEvent newIndex = anEvent oldIndex or: [ ignoreTextEvents ])
		ifTrue: [ ^ self ].
	lastWasText
		ifFalse: [ self completeWithCursor: false ].
	lastWasText := false
]

{ #category : #'private - list selection' }
GtCompletionController >> deselectAll [
	"Deselect all completion actions"

	listElement deselectAll
]

{ #category : #'event handling' }
GtCompletionController >> doubleClickList: anEvent [
	self completeWithCursor: true.
	textElement requestFocus
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
	ignoreTextEvents
		ifTrue: [ ^ aBlock value ].
	ignoreTextEvents := true.
	aBlock
		ensure: [ ignoreTextEvents := false ]
]

{ #category : #'initialize-release' }
GtCompletionController >> initialize [
	super initialize.

	drillDownActions := OrderedCollection new.
	strategy := GtCompletionStrategy new.

	cursorElement := nil.

	listElement := self newCompletionList.
	overlay := self newPopupElement.
	overlay addChild: listElement.

	completionDelay := BlDelayedTaskAction new.
	completionDelay delay: self class popupDelay.

	lastWasText := false.
	ignoreTextEvents := false
]

{ #category : #actions }
GtCompletionController >> install [
	eventHandlers := {(BlEventHandler
		on: BrTextEditorInsertedEvent
		do: [ :event | self textInserted: event ]).
	(BlEventHandler
		on: BrTextEditorDeletedEvent
		do: [ :event | self textDeleted: event ]).
	(BlEventHandler
		on: BrTextEditorCursorMovedEvent
		do: [ :event | self cursorMoved: event ])}.
	eventHandlers do: [ :each | self textEditor addEventHandler: each ].
	eventFilters := {(BlEventHandler
		on: BlKeystrokeEvent
		do: [ :event | self processKeystroke: event ]).
	(BlEventHandler
		on: BlKeyDownEvent
		do: [ :event | self processKeyDown: event ])}.
	eventFilters do: [ :each | textElement addEventFilter: each ].
	popupEventHandlers := {(BlEventHandler
		on: BrSelectionChanged
		do: [ :event | self onSelectionChanged: event ]).
	(BlEventHandler
		on: BlDoubleClickEvent
		do: [ :event | self doubleClickList: true ])}.
	popupEventHandlers do: [ :each | listElement addEventHandler: each ].
	popupEventFilters := {(BlEventHandler
		on: BlKeystrokeEvent
		do: [ :event | self processPopupKeystroke: event ])}.
	popupEventFilters do: [ :each | listElement addEventFilter: each ]
]

{ #category : #testing }
GtCompletionController >> isAtStartOfLine [
	| text position char aCursor |

	text := self text.
	aCursor := self textEditor cursor first.
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

	^ BrSimpleList new
		lookDo: [ :aLook | aLook listElement constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal matchParent.
			c maxHeight: 200 ] ];
		background: Color white;
		border: (BlBorder paint: Color lightGray width: 1);
		padding: (BlInsets all: 2);
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal matchParent ];
		display: #();
		stencil: [ :each :anIndex |
			BlTextElement new
				constraintsDo: [ :c | c horizontal matchParent ];
				padding: (BlInsets all: 5);
				text: (each displayString asRopedText thin monospace fontSize: 12) ]
]

{ #category : #'private - instance creation' }
GtCompletionController >> newPopupElement [
	^ GtCompletionPopupElement new
		layout: BlLinearLayout vertical;
		background: Color red;
		constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal exact: 200 ]
]

{ #category : #private }
GtCompletionController >> nextUncompletedItem: direction [
	| text position originalPosition aCursor |
	text := self text.
	aCursor := self textEditor cursor first.
	originalPosition := aCursor position.
	position := originalPosition.
	[ (position between: 1 and: text size) and: [ self isUncompletedAt: position ] ] whileTrue: [ position := position + direction ].
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
GtCompletionController >> onCursorAttached: aCursorElement [
	cursorElement := aCursorElement.
	overlay attachTo: cursorElement.
	overlay visibility: BlVisibility visible
]

{ #category : #'private - cursor' }
GtCompletionController >> onCursorDetached: aCursorElement [
	cursorElement := nil.
	overlay detach.
	overlay visibility: BlVisibility hidden
]

{ #category : #'private - list selection' }
GtCompletionController >> onSelectionChanged: anEvent [
	self scrollToSelected.
	self showPreview
]

{ #category : #private }
GtCompletionController >> position [
	^ self textEditor cursor first position
]

{ #category : #'event handling' }
GtCompletionController >> processKeyDown: anEvent [
	self isShowingPopup
		ifFalse: [ ^ self ].
	anEvent key = Key escape
		ifTrue: [ self removePopup.
			anEvent consumed: true ].
	(anEvent key = Key arrowRight and: [ anEvent modifiers isCmd ])
		ifTrue: [ self drillDown.
			anEvent consumed: true ].
	(anEvent key = Key arrowLeft and: [ anEvent modifiers isCmd ])
		ifTrue: [ self undoDrillDown.
			anEvent consumed: true ]
]

{ #category : #'event handling' }
GtCompletionController >> processKeystroke: anEvent [
	anEvent char = Character tab
		ifTrue: [ ^ self processTabKey: anEvent ].
	
	self isShowingPopup
		ifFalse: [ ^ self ].
	
	anEvent char = Character cr
		ifTrue: [ ^ self processReturnKey: anEvent ].
	
	self cancelPreview.
	
	anEvent char = Character arrowDown
		ifTrue: [
			self selectNextItem.
			anEvent consumed: true ].
	anEvent char = Character arrowUp
		ifTrue: [
			self selectPreviousItem.
			anEvent consumed: true ]
]

{ #category : #'event handling' }
GtCompletionController >> processPopupKeystroke: anEvent [
	self isShowingPopup
		ifFalse: [ ^ self ].
	anEvent char = Character tab
		ifTrue: [ self completeWithCursor: true.
			textElement requestFocus.
			^ anEvent consumed: true ]
]

{ #category : #'event handling' }
GtCompletionController >> processReturnKey: anEvent [
	self completeWithCursor: true.
	anEvent consumed: true
]

{ #category : #'event handling' }
GtCompletionController >> processTabKey: anEvent [
	| direction |
	self isShowingPopup
		ifTrue: [ self completeWithCursor: true.
			^ anEvent consumed: true ].
	self isAtStartOfLine
		ifFalse: [ direction := anEvent modifiers isShift
				ifTrue: [ -1 ]
				ifFalse: [ 1 ].
			(self moveCursorToNextUncompletedItem: direction)
				ifTrue: [ anEvent consumed: true ] ]
]

{ #category : #'private - popup' }
GtCompletionController >> removePopup [
	self cancelPreview.
	self terminatePopupDelay.
	overlay detach.
	overlay removeFromParent
]

{ #category : #private }
GtCompletionController >> removeUncompletedAttributeAt: anInteger [
	| text position |
	text := self text.
	position := anInteger.
	[ position <= text size and: [ self isUncompletedAt: position ] ] whileTrue: [ position := position + 1 ].
	(text from: anInteger to: position - 1) clearAttributes: [ :each | each isKindOf: GtCompletionPartAttribute ]
]

{ #category : #private }
GtCompletionController >> resetActions [
	previewAction := nil.
	drillDownActions := OrderedCollection new
]

{ #category : #'private - list selection' }
GtCompletionController >> scrollTo: anIndex [
	self flag: 'Implement corresponding list api'.

	listElement children first scrollToPosition: anIndex
]

{ #category : #'private - list selection' }
GtCompletionController >> scrollToSelected [
	self selectedCompletionIndexDo: [ :anIndex | self scrollTo: anIndex ]
]

{ #category : #'private - list selection' }
GtCompletionController >> selectAction: aCompletionAction [
	"Select the given completion action deselecting the other ones"

	self selectAt: (self completionActions indexOf: aCompletionAction ifAbsent: [ ^ self deselectAll ])
]

{ #category : #'private - list selection' }
GtCompletionController >> selectAt: anIndex [
	"Select a completion action at a given index deselecting all other ones"

	listElement selectOne: anIndex
]

{ #category : #'private - list selection' }
GtCompletionController >> selectFirst [
	"Select the first completion action deselecting the other ones"

	self selectAt: 1
]

{ #category : #'private - list selection' }
GtCompletionController >> selectNextItem [
	listElement selectNext
]

{ #category : #'private - list selection' }
GtCompletionController >> selectPreviousItem [
	listElement selectPrevious
]

{ #category : #private }
GtCompletionController >> selectUncompletedAt: position [
	| first last size |
	first := position - 1.
	[ first >= 1 and: [ self isUncompletedAt: first ] ] whileTrue: [ first := first - 1 ].
	last := position + 1.
	size := self text size.
	[ last <= size and: [ self isUncompletedAt: last ] ] whileTrue: [ last := last + 1 ].
	last := last - 1.
	self textEditor selecter
		overwrite;
		from: first to: last;
		withoutCursorUpdate;
		select
]

{ #category : #'private - list selection' }
GtCompletionController >> selectedCompletionIndexDo: aBlock [
	"Evaluate a given block with the current selection index if there is one"
	| aSelection |
	
	aSelection := listElement selection.
	aSelection isNotEmpty
		ifTrue: [ aBlock value: aSelection from ]
]

{ #category : #'private - list selection' }
GtCompletionController >> selectedCompletionItemDo: aBlock [
	"Evaluate a given block with the currently selected completion item if there is one"
	
	self selectedCompletionIndexDo: [ :anIndex |
		aBlock value: (self completionActions at: anIndex) ]
]

{ #category : #'private - popup' }
GtCompletionController >> showPopupAt: anIndex [
	"Show the completion popup selecting the first relevant completion item"

	self updatePopupItemsAt: anIndex autoSelect: true.

	(self isShowingPopup or: [ self completionActions isEmpty ])
		ifTrue: [ ^ self ].

	self
		assert: [ overlay isAttachedToSceneGraph not ]
		description: [ 'Overlay must not be already visible' ]. 

	self
		assert: [ textElement isAttachedToSceneGraph ]
		"otherwise how popup can be opened?"
		description: [ 'Text editor must be in the scene graph' ].

	textElement space root addChild: overlay
]

{ #category : #'private - preview' }
GtCompletionController >> showPreview [
	"Show completion preview for a currently selected action or remove
	the existing preview if none is selected"

	self cancelPreview.
	self applyPreview
]

{ #category : #'private - popup' }
GtCompletionController >> startCompletionAt: aTextIndex [
	self terminatePopupDelay.
	
	"If there are no completions for a given index, remove the popup"
	((self strategyAt: aTextIndex) hasCompletionsAt: aTextIndex in: self text)
		ifFalse: [ ^ self removePopup ].

	self isShowingPopup
		ifTrue: [ self updatePopupItemsAt: aTextIndex autoSelect: true ]
		ifFalse: [ self startPopupDelayAt: aTextIndex ]
]

{ #category : #'private - popup' }
GtCompletionController >> startPopupDelayAt: anIndex [
	"Completion delay must already have element: attached,
	see ${method:GtCompletionController>>#textElement:}$"

	completionDelay action: [ self showPopupAt: anIndex ].
	completionDelay start
]

{ #category : #'initialize-release' }
GtCompletionController >> strategy: aCompletionStrategy [
	strategy := aCompletionStrategy
]

{ #category : #private }
GtCompletionController >> strategyAt: anIndex [
	| result |
	result := strategy.
	(self text attributesAt: anIndex)
		do: [ :each | 
			(each isKindOf: GtCompletionStrategyAttribute)
				ifTrue: [ result := each strategy ] ].
	^ result
]

{ #category : #'private - popup' }
GtCompletionController >> terminatePopupDelay [
	completionDelay stop
]

{ #category : #'private - accessing' }
GtCompletionController >> text [
	<return: #BlText>

	^ self textEditor text
]

{ #category : #'event handling' }
GtCompletionController >> textDeleted: anEvent [
	ignoreTextEvents
		ifFalse: [ self startCompletionAt: anEvent fromIndex - 1 ].
	lastWasText := true
]

{ #category : #'private - accessing' }
GtCompletionController >> textEditor [
	<return: #BrTextEditor>

	^ textElement editor
]

{ #category : #'initialize-release' }
GtCompletionController >> textElement: anEditorElement [
	textElement := anEditorElement.
	textElement
		when: BrTextEditorCursorElementAddedEvent
		do: [ :anEvent | self onCursorAttached: anEvent cursorElement ].
	textElement
		when: BrTextEditorCursorElementRemovedEvent
		do: [ :anEvent | self onCursorDetached: anEvent cursorElement ].

	completionDelay element: textElement
]

{ #category : #'event handling' }
GtCompletionController >> textInserted: anEvent [
	ignoreTextEvents
		ifFalse: [ self startCompletionAt: anEvent index + 1 ].
	lastWasText := true
]

{ #category : #private }
GtCompletionController >> undoDrillDown [
	drillDownActions isEmpty
		ifTrue: [ ^ false ].
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

{ #category : #actions }
GtCompletionController >> uninstall [
	popupEventFilters do: [ :each | listElement removeEventFilter: each ].
	popupEventHandlers do: [ :each | listElement removeEventHandler: each ].
	eventFilters do: [ :each | textElement removeEventFilter: each ].
	eventHandlers do: [ :each | self textEditor removeEventHandler: each ]
]

{ #category : #'private - popup' }
GtCompletionController >> updatePopupItemsAt: anIndex autoSelect: shouldSelectFirst [
	| theActions |

	theActions := [ (self strategyAt: anIndex) completionActionsFor: self text at: anIndex max: MaxPopupItems ]
		on: Error
		do: [ :ex | ex return: #() ].

	"action is deselected => preview is cancelled"
	self deselectAll.
	self completionActions: theActions.

	theActions
		ifEmpty: [ ^ self removePopup ].

	shouldSelectFirst
		ifFalse: [ ^ self ].

	"first item is selected => preview is shown"
	self selectFirst
]
