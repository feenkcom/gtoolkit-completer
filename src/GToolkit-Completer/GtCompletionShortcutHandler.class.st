"
I am a custom shortcut handler to be used by completion controller.

I only process shortcuts if a completion popup is opened, otherwise I ignore them


"
Class {
	#name : #GtCompletionShortcutHandler,
	#superclass : #BlShortcutHandlerWithShortcuts,
	#instVars : [
		'completionController',
		'consumeEvent',
		'whenActive'
	],
	#category : #'GToolkit-Completer-UI'
}

{ #category : #accessing }
GtCompletionShortcutHandler >> completionController [
	<return: #GtCompletionController>

	^ completionController
]

{ #category : #accessing }
GtCompletionShortcutHandler >> completionController: aCompletionController [
	completionController := aCompletionController
]

{ #category : #accessing }
GtCompletionShortcutHandler >> consumeEvent [
	^ consumeEvent
]

{ #category : #accessing }
GtCompletionShortcutHandler >> consumeEvent: aBoolean [
	consumeEvent := aBoolean
]

{ #category : #'api - event managing' }
GtCompletionShortcutHandler >> handleEvent: anEvent [
	consumeEvent := true.
	super handleEvent: anEvent.
	consumeEvent
		ifFalse: [ anEvent beNotConsumed ]
]

{ #category : #'initialize-release' }
GtCompletionShortcutHandler >> initialize [
	super initialize.
	whenActive := true
]

{ #category : #'api - event managing' }
GtCompletionShortcutHandler >> wantsEvent: anEvent [
	^ self completionController isActive = whenActive
		and: [ super wantsEvent: anEvent ]
]

{ #category : #'initialize-release' }
GtCompletionShortcutHandler >> whenActive [
	whenActive := true
]

{ #category : #'initialize-release' }
GtCompletionShortcutHandler >> whenInactive [
	whenActive := false
]
