Class {
	#name : #GtCompletionCancelPreviewSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'action'
	],
	#category : #'GToolkit-Completer-Signals'
}

{ #category : #testing }
GtCompletionCancelPreviewSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	Excluding these signals makes a good starting point for application specific logging, or logging unexpected signals"

	^ true.
]

{ #category : #accessing }
GtCompletionCancelPreviewSignal >> action [
	^ action
]

{ #category : #accessing }
GtCompletionCancelPreviewSignal >> action: anObject [
	action := anObject
]

{ #category : #printing }
GtCompletionCancelPreviewSignal >> printOneLineContentsOn: aStream [

	self action ifNil: [ 
		aStream
			<< 'a ';
			print: self class name;
			<< ' without an action'.
		^self ].
	self action label printOn: aStream
]
