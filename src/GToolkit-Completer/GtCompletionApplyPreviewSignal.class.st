Class {
	#name : 'GtCompletionApplyPreviewSignal',
	#superclass : 'ContextStackSignal',
	#instVars : [
		'action'
	],
	#category : 'GToolkit-Completer-Signals'
}

{ #category : 'accessing' }
GtCompletionApplyPreviewSignal >> action [
	^ action
]

{ #category : 'accessing' }
GtCompletionApplyPreviewSignal >> action: anObject [
	action := anObject
]

{ #category : 'printing' }
GtCompletionApplyPreviewSignal >> printOneLineContentsOn: aStream [

	self action ifNil: [ 
		aStream
			<< 'a ';
			print: self class name;
			<< ' without an action'.
		^self ].
	self action label printOn: aStream
]
