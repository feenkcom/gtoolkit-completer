"
I am a custom shortcut handler to be used by completion controller.

I only process shortcuts if a completion popup is opened, otherwise I ignore them
"
Class {
	#name : #GtCompletionShortcutHander,
	#superclass : #BlShortcutHandler,
	#instVars : [
		'completionController'
	],
	#category : #'GToolkit-Completer-UI'
}

{ #category : #accessing }
GtCompletionShortcutHander >> completionController [
	<return: #GtCompletionController>

	^ completionController
]

{ #category : #accessing }
GtCompletionShortcutHander >> completionController: aCompletionController [
	completionController := aCompletionController
]

{ #category : #'api - event managing' }
GtCompletionShortcutHander >> wantsEvent: anEvent [
	^ self completionController isActive and: [ super wantsEvent: anEvent ]
]
