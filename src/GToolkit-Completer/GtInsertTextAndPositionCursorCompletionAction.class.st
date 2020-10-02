Class {
	#name : #GtInsertTextAndPositionCursorCompletionAction,
	#superclass : #GtInsertTextCompletionAction,
	#instVars : [
		'newPosition'
	],
	#category : #'GToolkit-Completer-Actions'
}

{ #category : #'instance creation' }
GtInsertTextAndPositionCursorCompletionAction class >> labeled: aString completion: completionString position: anInteger from: searchStartInteger newPosition: newPositionInteger [
	^ (super
		labeled: aString
		completion: completionString
		position: anInteger
		from: searchStartInteger)
		newPosition: newPositionInteger;
		yourself
]

{ #category : #executing }
GtInsertTextAndPositionCursorCompletionAction >> moveCursorOn: aCompletionController [
	aCompletionController textEditor moveCursorTo: newPosition
]

{ #category : #accessing }
GtInsertTextAndPositionCursorCompletionAction >> newPosition [
	^ newPosition
]

{ #category : #accessing }
GtInsertTextAndPositionCursorCompletionAction >> newPosition: anInteger [
	newPosition := anInteger
]
