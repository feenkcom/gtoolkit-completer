Class {
	#name : #GtCompletionApplyPreviewSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'action'
	],
	#category : #'GToolkit-Completer-Signals'
}

{ #category : #testing }
GtCompletionApplyPreviewSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	Excluding these signals makes a good starting point for application specific logging, or logging unexpected signals"

	^ true.
]

{ #category : #accessing }
GtCompletionApplyPreviewSignal >> action [
	^ action
]

{ #category : #accessing }
GtCompletionApplyPreviewSignal >> action: anObject [
	action := anObject
]

{ #category : #printing }
GtCompletionApplyPreviewSignal >> printOneLineContentsOn: aStream [

	self action ifNil: [ 
		aStream
			<< 'a ';
			print: self class name;
			<< ' without an action'.
		^self ].
	self action label printOn: aStream
]
